import 'package:flutter/material.dart';
import 'package:skinca/views/auth/forget_password/forget_password.dart';
import 'package:skinca/views/auth/forget_password/verification_code.dart';
import 'package:skinca/views/auth/login_page.dart';
import 'package:skinca/views/auth/sign_up/sign_up_page.dart';
import 'package:skinca/views/chat/chat_page.dart';
import 'package:skinca/views/disease_details/disease_details.dart';
import 'package:skinca/views/doctor_details/doctor_details.dart';
import 'package:skinca/views/entrypoint/entrypoint_ui.dart';
import 'package:skinca/views/home/home.dart';
import 'package:skinca/views/notification/notification_page.dart';
import 'package:skinca/views/onboarding/onboarding_page.dart';
import 'package:skinca/views/profile/profile.dart';
import 'package:skinca/views/profile/screens/profile_info.dart';
import 'package:skinca/views/search/search_page.dart';
import '../../views/auth/forget_password/create_new_password.dart';

final Map<String, WidgetBuilder> routes = {
  EntryPointUI.routeName: (context) => const EntryPointUI(),
  SearchPage.routeName: (context) => const SearchPage(),
  ChatPage.routeName: (context) => ChatPage(),
  NotificationPage.routeName: (context) => const NotificationPage(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  ForgetPassword.routeName: (context) => const ForgetPassword(),
  CreateNewPassword.routeName: (context) => const CreateNewPassword(),
  VerificationCode.routeName: (context) => VerificationCode(),
  HomePage.routeName: (context) =>  const HomePage(),
  OnboardingPage.routeName: (context) => const OnboardingPage(),
  DoctorDetailsPage.routeName: (context) => const DoctorDetailsPage(),
  DiseaseDetailsPage.routeName: (context) => const DiseaseDetailsPage(),
  ProfileInfoPage.routeName: (context) => const ProfileInfoPage(),
};
