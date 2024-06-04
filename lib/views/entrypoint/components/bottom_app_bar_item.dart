import 'package:flutter/material.dart';

class BottomAppBarItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  const BottomAppBarItem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: isActive ? activeColor : inactiveColor,
      ),
      onPressed: onTap,
    );
  }
}
