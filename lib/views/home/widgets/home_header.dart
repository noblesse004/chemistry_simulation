import 'package:flutter/material.dart';

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
            // Bạn có thể chuyển Icon tài khoản từ AppBar xuống đây cho hiện đại
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ],
        ),
      ],
    );
  }
}
