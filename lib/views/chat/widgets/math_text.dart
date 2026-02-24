import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class MathText extends StatelessWidget {
  final String text;
  final Color textColor;

  const MathText({
    super.key,
    required this.text,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    // Tách văn bản theo dòng để giữ cấu trúc danh sách/đoạn văn
    final lines = text.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.trim().isEmpty) return const SizedBox(height: 8);

        final segments = line.split('\$');
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: segments.asMap().entries.map((entry) {
              int i = entry.key;
              String segment = entry.value;

              if (i % 2 == 1) {
                // Render công thức hóa học
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Math.tex(
                    segment,
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: textColor == Colors.white
                          ? Colors.white
                          : Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              // Văn bản bình thường
              return Text(
                segment,
                style: TextStyle(fontSize: 16, color: textColor, height: 1.4),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
