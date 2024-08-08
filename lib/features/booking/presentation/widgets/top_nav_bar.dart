import 'package:fixit_provider/common/color_extension.dart';
import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const TopNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Tcolor.secondryColor2,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Pending', 0),
          _buildNavItem('Upcoming', 1),
          _buildNavItem('Cancelled', 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return TextButton(
        onPressed: () => onItemTapped(index),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedIndex == index ? Tcolor.black : Tcolor.gray),
        ));
  }
}
