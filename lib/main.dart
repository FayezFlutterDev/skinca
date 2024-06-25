import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/constants/routes.dart';
import 'package:skinca/views/auth/auth_cubit/user_cubit.dart';
import 'package:skinca/views/home/home_cubit/home_cubit.dart';
import 'package:skinca/views/home/theme_cubit.dart';

import 'core/api/dio_consumer.dart';


Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => UserCubit(DioConsumer(dio: Dio())),
          ),
          BlocProvider(
            create: (context) => HomeCubit(DioConsumer(dio: Dio()))..getBanners()..getDiseases()..getDoctors(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    // ignore: avoid_print
    print('runZonedGuarded: Caught error in my root zone.');
  });
}

/// Allows the ability to scroll by dragging with touch, mouse, and trackpad.
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SkinCa',
          routes: routes,
          initialRoute: "/onboarding",
          themeMode: state.themeMode,
          theme: ThemeData(
            colorSchemeSeed: state.colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: state.colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          scrollBehavior: CustomScrollBehavior(),
        );
      },
    );
  }
}
