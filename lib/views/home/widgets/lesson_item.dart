import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LessonItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const LessonItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        trailing: const Icon(
          Icons.play_circle_fill,
          color: AppColors.secondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
