import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import 'widgets/home_header.dart';
import 'widgets/feature_card.dart';
import 'widgets/lesson_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Chemistry Hub Lớp 9',
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
            const HomeHeader(userName: "Duy"),
            const SizedBox(height: 25),
            FeatureCard(
              title: "Phòng thí nghiệm ảo",
              subtitle: "Mô phỏng phản ứng Axit, Bazơ, Muối",
              icon: Icons.biotech,
              color: AppColors.primary,
              onTap: () => Navigator.pushNamed(context, AppRoutes.lab),
            ),

            const SizedBox(height: 16),

            FeatureCard(
              title: "Gia sư AI Chemmy",
              subtitle: "Giải đáp mọi thắc mắc hóa học 24/7",
              icon: Icons.psychology,
              color: Colors.purple,
              onTap: () => Navigator.pushNamed(context, AppRoutes.chat),
            ),

            const SizedBox(height: 24),

            // 4. Tiêu đề mục bài giảng
            _buildSectionHeader(context),

            const SizedBox(height: 10),

            // 5. Danh sách các bài học tiêu biểu
            LessonItem(
              title: "Bài 1: Tính chất hóa học của Oxit",
              onTap: () => Navigator.pushNamed(context, AppRoutes.lectures),
            ),
            LessonItem(
              title: "Bài 3: Tính chất hóa học của Axit",
              onTap: () => Navigator.pushNamed(context, AppRoutes.lectures),
            ),
            LessonItem(
              title: "Bài 7: Tính chất hóa học của Bazơ",
              onTap: () => Navigator.pushNamed(context, AppRoutes.lectures),
            ),
          ],
        ),
      ),
    );
  }

  // Widget nội bộ để quản lý tiêu đề phần bài giảng
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
