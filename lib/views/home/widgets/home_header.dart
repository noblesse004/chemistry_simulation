import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import để dùng lệnh Sign Out
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1. Phần lời chào (Giữ nguyên cấu trúc của Duy)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chào $userName,",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "hôm nay học gì nào?",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),

            // 2. Avatar tích hợp nút Logout (Đã sửa đổi)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'logout') {
                  // Thực hiện đăng xuất khỏi Firebase
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    // Đẩy về màn hình Auth và xóa sạch lịch sử các màn hình trước đó
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.auth,
                      (route) => false,
                    );
                  }
                }
              },
              // Chỉnh vị trí menu xuất hiện bên dưới Avatar
              offset: const Offset(0, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Đăng xuất",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // Đây chính là cái Avatar cũ của Duy nhưng đã bỏ 'const'
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
