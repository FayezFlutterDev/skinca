import 'package:flutter/material.dart';

enum ColorSelection {
  deepPurple('Deep Purple', Colors.deepPurple),
  purple('Purple', Colors.purple),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSelection(this.label, this.color);
  final String label;
  final Color color;
}

class AppColors {
  /* <----------- Colors ------------> */
  /// Primary Color of this App
  static const Color primary = Color(0xFF1B998F);

  // Others Color
  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  /// used for page with box background
  static const Color scaffoldWithBoxBackground = Color(0xFFF7F7F7);
  static const Color cardColor = Color(0xFFF2F2F2);
  static const Color coloredBackground = Color(0xFFE4F8EA);
  static const Color placeholder = Color(0xFF8B8B97);
  static const Color textInputBackground = Color(0xFFF7F7F7);
  static const Color separator = Color(0xFFFAFAFA);
  static const Color grey = Color(0xFF9E9E9E);
}
