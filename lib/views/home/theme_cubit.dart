import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/constants.dart';


class ThemeState {
  final ThemeMode themeMode;
  final ColorSelection colorSelected;

  ThemeState({required this.themeMode, required this.colorSelected});

  ThemeState copyWith({ThemeMode? themeMode, ColorSelection? colorSelected}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      colorSelected: colorSelected ?? this.colorSelected,
    );
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  bool isDarkMode = false;
  ThemeCubit()
      : super(ThemeState(
          themeMode: ThemeMode.light,
          colorSelected: ColorSelection.teal,
        ));

  void changeThemeMode(bool useLightMode) {
    isDarkMode = !useLightMode;
    emit(state.copyWith(
      themeMode: useLightMode ? ThemeMode.light : ThemeMode.dark,
    ));
  }

  void changeColor(int value) {
    emit(state.copyWith(
      colorSelected: ColorSelection.values[value],
    ));
  }
}
