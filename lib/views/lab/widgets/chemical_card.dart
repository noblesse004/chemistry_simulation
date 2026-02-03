import 'package:flutter/material.dart';

class ChemicalCard extends StatelessWidget {
  final String name;
  final Color color;
  final VoidCallback? onTap; // Thêm callback để xử lý khi nhấn

  const ChemicalCard({
    super.key,
    required this.name,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Sử dụng GestureDetector để nhận diện cú chạm
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.vaping_rooms, size: 30, color: Colors.black54),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
