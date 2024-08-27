import 'package:flutter/material.dart';

class CustomViewButton extends StatelessWidget {
  final String view;
  final String currentView;
  final ValueChanged<String> onViewSelected;

  const CustomViewButton({
    super.key,
    required this.view,
    required this.currentView,
    required this.onViewSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentView == view.toLowerCase();
    return GestureDetector(
      onTap: () => onViewSelected(view.toLowerCase()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Text(
          view,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
