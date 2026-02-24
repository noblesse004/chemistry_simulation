import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import 'widgets/home_header.dart';
import 'widgets/feature_card.dart';
import 'widgets/lesson_item.dart';
import '../lectures/video_player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // 1. DANH SÁCH BÀI GIẢNG ĐỘNG
  final List<Map<String, String>> lectures = const [
    {"title": "Bài 3: Tính chất hóa học của Axit", "videoId": "tRsCe1VV0J8"},
    {"title": "Bài 7: Tính chất hóa học của Bazơ", "videoId": "dQw4w9WgXcQ"},
    {"title": "Bài 9: Tính chất hóa học của Muối", "videoId": "yPYZpwSpKmA"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Hoá học Lớp 9',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header chào mừng
            const HomeHeader(userName: "Duy"),
            const SizedBox(height: 25),

            // Thẻ tính năng Lab
            FeatureCard(
              title: "Phòng thí nghiệm ảo",
              subtitle: "Mô phỏng phản ứng Axit, Bazơ, Muối",
              icon: Icons.biotech,
              color: AppColors.primary,
              onTap: () => Navigator.pushNamed(context, AppRoutes.lab),
            ),

            const SizedBox(height: 16),

            // Thẻ tính năng AI Chat
            FeatureCard(
              title: "Gia sư AI Chemmy",
              subtitle: "Giải đáp mọi thắc mắc hóa học 24/7",
              icon: Icons.psychology,
              color: Colors.purple,
              onTap: () => Navigator.pushNamed(context, AppRoutes.chat),
            ),

            const SizedBox(height: 24),

            // Tiêu đề phần bài giảng
            _buildSectionHeader(context),

            const SizedBox(height: 10),

            // 2. HIỂN THỊ DANH SÁCH BÀI GIẢNG
            ...lectures.map((item) {
              return LessonItem(
                title: item['title']!,
                onTap: () {
                  // ĐÃ FIX LỖI: Truyền cả videoId và title vào constructor
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                        videoId: item['videoId']!,
                        title: item['title']!,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Widget quản lý tiêu đề phần bài giảng
  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Chương trình trọng tâm",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.lectures),
          child: const Text("Xem tất cả"),
        ),
      ],
    );
  }
}
