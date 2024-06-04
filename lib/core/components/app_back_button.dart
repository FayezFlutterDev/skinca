import 'package:flutter/material.dart';
import 'package:skinca/core/constants/icon_borken.dart';

class AppBackButton extends StatelessWidget {
  /// Custom Back labelLarge with a custom ICON for this app
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        IconBroken.Arrow___Left_2,
        size: 38,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
