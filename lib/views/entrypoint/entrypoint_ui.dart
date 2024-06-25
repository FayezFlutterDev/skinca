
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinca/core/components/verified_dialog.dart';
import 'package:skinca/core/constants/icon_borken.dart';
import 'package:skinca/views/chat/messages_page.dart';
import 'package:skinca/views/home/home.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_states.dart';
import 'package:skinca/views/profile/profile.dart';
import 'package:skinca/views/search/search_page.dart';

import '../../core/constants/constants.dart';
import '../home/theme_cubit.dart';
import 'components/app_navigation_bar.dart';

class EntryPointUI extends StatefulWidget {
  static const String routeName = "/";
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const SearchPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.scaffoldBackground,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return FloatingActionButton(
              heroTag: 'chatbotFAB',
              onPressed: () {
                ImagePicker()
                    .pickImage(source: ImageSource.camera)
                    .then((value) {
                  if (value != null) {
                    context.read<HomeCubit>().uploadScanPic(value);
                  }
                });
                if (state is ScanSuccess && state.status == true) {
                  showGeneralDialog(
                    barrierLabel: 'Dialog',
                    barrierDismissible: true,
                    context: context,
                    pageBuilder: (ctx, anim1, anim2) => VerifiedDialog(
                      text: 'Scan Result',
                      text2: state.prediction,
                      text3: 'Ok',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, EntryPointUI.routeName, (route) => false);
                      },
                    ),
                    transitionBuilder: (ctx, anim1, anim2, child) =>
                        ScaleTransition(
                      scale: anim1,
                      child: child,
                    ),
                  );
                }
              },
              backgroundColor: AppColors.primary,
              child: const Icon(
                IconBroken.Scan,
                color: Colors.white,
                size: 43,
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return AppBottomNavigationBar(
            currentIndex: currentIndex,
            onNavTap: onBottomNavigationTap,
          );
        },
      ),
    );
  }
}
