import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.bar_chart, 'Markets', 0),
          _buildNavItem(Icons.view_timeline, 'Square', 1),
          _buildNavItem(Icons.swap_horizontal_circle, 'Trade', 2),
          _buildNavItem(Icons.diamond, 'Discover', 3),
          _buildNavItem(Icons.wysiwyg, 'Portfolio', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey,
            size: isSelected ? 42 : 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontSize: isSelected ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }
}
