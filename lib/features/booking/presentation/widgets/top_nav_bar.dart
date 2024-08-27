import 'package:fixit_provider/common/color_extension.dart';
import 'package:flutter/material.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const TopNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  // ignore: library_private_types_in_public_api
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Tcolor.primaryColor1.withOpacity(0.3),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      title: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Pending', Icons.pending, 0),
            _buildNavItem('Upcoming', Icons.calendar_today, 1),
            _buildNavItem('Cancelled', Icons.cancel, 2),
            _buildNavItem('Completed', Icons.check_circle, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, int index) {
    bool isSelected = widget.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        widget.onItemTapped(index);
        _scrollToItem(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isSelected ? Tcolor.primaryColor1 : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected ? Colors.white : Tcolor.gray,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Tcolor.gray,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Tcolor.primaryColor1,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _scrollToItem(int index) {
    double scrollPosition = index *
        (100.0 + 24.0); // Adjust 100.0 and 24.0 based on item size and padding

    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
