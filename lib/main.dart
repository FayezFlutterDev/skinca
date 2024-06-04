import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/constants/routes.dart';
import 'package:skinca/example.dart';
import 'package:skinca/views/home/theme_cubit.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: const MyApp(),
  ));
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
          // routes: routes,
          // initialRoute: "/",
          home: Examp(),
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
