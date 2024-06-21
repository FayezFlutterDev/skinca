import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/views/chat/chat_page.dart';
import 'package:skinca/views/home/home.dart';
import 'package:skinca/views/notification/notification_page.dart';
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
    ChatPage(),
    const NotificationPage(),
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'chatbotFAB',
        onPressed: () {
          Navigator.pushNamed(context, ChatPage.routeName);
        },
        backgroundColor: AppColors.primary,
        child: Image.asset("assets/images/chatbot.png"),
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
