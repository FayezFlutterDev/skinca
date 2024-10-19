import 'package:flutter/material.dart';
import 'package:skinca/core/constants/icon_borken.dart';

import '../../../core/constants/constants.dart';
import 'bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return currentIndex == 0 ? Icons.home_filled : IconBroken.Home;
      case 1:
        return currentIndex == 1 ? IconBroken.Search : Icons.search_outlined;
      case 2:
        return currentIndex == 2 ? Icons.face : Icons.face_retouching_off;
      case 3:
        return currentIndex == 3 ? Icons.message : IconBroken.Chat;
      case 4:
        return currentIndex == 4 ? Icons.person : IconBroken.Profile;
      default:
        return Icons.home_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final selectedItemColor = theme.colorScheme.primary;
    final unselectedItemColor = theme.iconTheme.color!.withOpacity(0.6);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            icon: _getIcon(0),
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
            activeColor: selectedItemColor,
            inactiveColor: unselectedItemColor,
          ),
          BottomAppBarItem(
            icon: _getIcon(1),
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
            activeColor: selectedItemColor,
            inactiveColor: unselectedItemColor,
          ),
          const Padding(
            padding: EdgeInsets.all(AppDefaults.padding * 2),
            child: SizedBox(width: AppDefaults.margin),
          ),
          BottomAppBarItem(
            icon: _getIcon(3),
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
            activeColor: selectedItemColor,
            inactiveColor: unselectedItemColor,
          ),
          BottomAppBarItem(
            icon: _getIcon(4),
            isActive: currentIndex == 4,
            onTap: () => onNavTap(4),
            activeColor: selectedItemColor,
            inactiveColor: unselectedItemColor,
          ),
        ],
      ),
    );
  }
}
