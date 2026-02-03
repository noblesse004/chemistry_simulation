import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LectureListScreen extends StatelessWidget {
  const LectureListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chương trình Hóa học 9"),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        children: [
          _buildChapter("Chương 1: Các loại hợp chất vô cơ", [
            "Bài 1: Tính chất hóa học của Oxit",
            "Bài 2: Một số Oxit quan trọng",
            "Bài 3: Tính chất hóa học của Axit",
            "Bài 4: Một số Axit quan trọng",
            "Bài 5: Luyện tập: Tính chất hóa học của Oxit và Axit",
          ]),
          _buildChapter("Chương 2: Kim loại", [
            "Bài 15: Tính chất vật lý của Kim loại",
            "Bài 16: Tính chất hóa học của Kim loại",
            "Bài 17: Dãy hoạt động hóa học của Kim loại",
          ]),
        ],
      ),
    );
  }

  Widget _buildChapter(String title, List<String> lessons) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      children: lessons
          .map(
            (lesson) => ListTile(
              leading: const Icon(Icons.play_lesson_outlined, size: 20),
              title: Text(lesson),
              onTap: () {
                // Điều hướng đến chi tiết bài giảng hoặc video
              },
            ),
          )
          .toList(),
    );
  }
}
