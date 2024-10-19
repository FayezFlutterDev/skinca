// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinca/core/constants/app_defaults.dart';
import 'package:skinca/views/auth/auth_cubit/user_cubit.dart';
import 'package:skinca/views/auth/auth_cubit/user_state.dart';
import 'package:skinca/views/auth/forget_password/create_new_password.dart';
import 'package:skinca/views/home/components/color_button.dart';
import 'package:skinca/views/home/components/theme_button.dart';
import 'package:skinca/views/home/theme_cubit.dart';
import 'package:skinca/views/onboarding/onboarding_page.dart';
import 'package:skinca/views/profile/screens/contact_us.dart';
import 'package:skinca/views/profile/screens/diseases.dart';
import 'package:skinca/views/profile/screens/doctors.dart';
import 'package:skinca/views/profile/screens/help_page.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      backgroundColor: const Color(0xFF009788),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isExpanded ? 60 : 200,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    color: Color(0xFF009788),
                  ),
                  child: !isExpanded
                      ? FittedBox(
                          child: Column(
                            children: [
                              context.read<UserCubit>().profilePic == null
                                  ? Stack(children: [
                                      CircleAvatar(
                                          radius:
                                              getProportionateScreenWidth(45),
                                          backgroundImage: context
                                                      .read<UserCubit>()
                                                      .user
                                                      ?.picture !=
                                                  null
                                              ? Image.memory(
                                                  const Base64Decoder().convert(
                                                      context
                                                          .read<UserCubit>()
                                                          .user!
                                                          .picture!),
                                                  fit: BoxFit.cover,
                                                ).image
                                              : const AssetImage(
                                                  "assets/images/avatar.png")),
                                      Positioned(
                                          bottom: 10,
                                          right: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery)
                                                  .then((value) {
                                                if (value != null) {
                                                  context
                                                      .read<UserCubit>()
                                                      .uploadProfilePic(value);
                                                }
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              radius: 10,
                                              child: const Icon(
                                                Icons.camera_alt,
                                                size: 15,
                                              ),
                                            ),
                                          ))
                                    ])
                                  : CircleAvatar(
                                      radius: getProportionateScreenWidth(35),
                                      backgroundImage: FileImage(File(context
                                          .read<UserCubit>()
                                          .profilePic!
                                          .path)),
                                    ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              if (context.read<UserCubit>().user != null)
                                Text(
                                  context.read<UserCubit>().user?.name ??
                                      context
                                          .read<UserCubit>()
                                          .registerResponse!
                                          .name,
                                  style: textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                SizedBox(
                                  width: getProportionateScreenHeight(20),
                                ),
                                CircleAvatar(
                                  radius: getProportionateScreenHeight(16),
                                  backgroundImage: (context
                                              .read<UserCubit>()
                                              .user!
                                              .picture !=
                                          null)
                                      ? Image.memory(
                                          const Base64Decoder().convert(context
                                              .read<UserCubit>()
                                              .user!
                                              .picture!),
                                          fit: BoxFit.cover,
                                        ).image
                                      : const AssetImage(
                                          "assets/images/avatar.png"),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(10),
                                ),
                                if (context.read<UserCubit>().user != null)
                                  Text(
                                    context.read<UserCubit>().user?.name ?? "",
                                    style: textTheme.bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )
                              ],
                            )),
                          ],
                        ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ExpansionTileItem(
                              textTheme: textTheme,
                              text: 'Profile Info',
                              icon: Icons.person,
                              nextPage: '/profile-info',
                            ),
                            ExpansionTile(
                              onExpansionChanged: (v) {
                                setState(() {
                                  isExpanded = v;
                                });
                              },
                              title: Text(
                                'Settings',
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              leading: Icon(
                                Icons.settings,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              trailing: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 600),
                                child: isExpanded
                                    ? Icon(
                                        Icons.arrow_back_ios,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      )
                                    : Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                              ),
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(children: [
                                      ListTile(
                                        title: Text(
                                          'Language',
                                          style: textTheme.titleMedium,
                                        ),
                                        leading: const Icon(Icons.language),
                                        onTap: () => print('Language tapped'),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Change Password',
                                          style: textTheme.titleMedium,
                                        ),
                                        leading: const Icon(Icons.lock),
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                CreateNewPassword.routeName),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Help',
                                          style: textTheme.titleMedium,
                                        ),
                                        leading: const Icon(Icons.help),
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(HelpPage.routeName),
                                      ),
                                      BlocBuilder<ThemeCubit, ThemeState>(
                                        builder: (context, state) {
                                          return ListTile(
                                            title: context
                                                    .read<ThemeCubit>()
                                                    .isDarkMode
                                                ? const Text("Light Mode")
                                                : const Text("Dark Mode"),
                                            leading: context
                                                    .read<ThemeCubit>()
                                                    .isDarkMode
                                                ? const Icon(Icons.light_mode)
                                                : const Icon(Icons.dark_mode),
                                            trailing: ThemeButton(
                                              changeThemeMode:
                                                  (bool useLightMode) {
                                                context
                                                    .read<ThemeCubit>()
                                                    .changeThemeMode(
                                                        useLightMode);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      BlocBuilder<ThemeCubit, ThemeState>(
                                        builder: (context, state) {
                                          return ListTile(
                                            title: const Text("Color"),
                                            leading:
                                                const Icon(Icons.color_lens),
                                            trailing: ColorButton(
                                              changeColor: (int value) {
                                                context
                                                    .read<ThemeCubit>()
                                                    .changeColor(value);
                                              },
                                              colorSelected:
                                                  state.colorSelected,
                                            ),
                                          );
                                        },
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                            ExpansionTileItem(
                              textTheme: textTheme,
                              text: 'Contact Us',
                              icon: Icons.contact_phone,
                              nextPage: ContactUsPage.routeName,
                            ),
                            ExpansionTileItem(
                              textTheme: textTheme,
                              text: 'Doctors',
                              icon: Icons.people,
                              nextPage: DoctorsPage.routeName,
                            ),
                            ExpansionTileItem(
                              textTheme: textTheme,
                              text: 'Disease',
                              icon: Icons.local_hospital_rounded,
                              nextPage: DiseasesPage.routeName,
                            ),
                            ExpansionTileItem(
                              textTheme: textTheme,
                              text: 'Log Out',
                              icon: Icons.logout,
                              nextPage: OnboardingPage.routeName,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExpansionTileItem extends StatelessWidget {
  const ExpansionTileItem({
    super.key,
    required this.textTheme,
    required this.text,
    required this.icon,
    required this.nextPage,
  });

  final TextTheme textTheme;
  final String text;
  final IconData icon;
  final String nextPage;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      enabled: false,
      title: Text(
        text,
        style: textTheme.titleMedium!,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(nextPage);
        },
        child: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
