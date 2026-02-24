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
            "Bài 2: Một số Oxit quan trọng (CaO, SO2)",
            "Bài 3: Tính chất hóa học của Axit",
            "Bài 4: Một số Axit quan trọng (HCl, H2SO4)",
            "Bài 5: Luyện tập: Tính chất hóa học của Oxit và Axit",
            "Bài 7: Tính chất hóa học của Bazơ",
            "Bài 8: Một số Bazơ quan trọng (NaOH, Ca(OH)2)",
            "Bài 9: Tính chất hóa học của Muối",
            "Bài 10: Một số Muối quan trọng (NaCl, KNO3)",
            "Bài 11: Phân bón hóa học",
            "Bài 12: Mối quan hệ giữa các loại hợp chất vô cơ",
          ]),
          _buildChapter("Chương 2: Kim loại", [
            "Bài 15: Tính chất vật lý của Kim loại",
            "Bài 16: Tính chất hóa học của Kim loại",
            "Bài 17: Dãy hoạt động hóa học của Kim loại",
            "Bài 18: Nhôm (Al)",
            "Bài 19: Sắt (Fe)",
            "Bài 20: Hợp kim sắt: Gang, Thép",
            "Bài 21: Sự ăn mòn kim loại và bảo vệ kim loại",
          ]),
          _buildChapter("Chương 3: Phi kim - Bảng tuần hoàn", [
            "Bài 25: Tính chất chung của Phi kim",
            "Bài 26: Clo (Cl2)",
            "Bài 27: Cacbon (C)",
            "Bài 28: Các oxit của Cacbon (CO, CO2)",
            "Bài 29: Axit cacbonic và Muối Cacbonat",
            "Bài 30: Silicon. Công nghiệp Silicat",
            "Bài 31: Sơ lược về bảng tuần hoàn các nguyên tố hóa học",
          ]),
          _buildChapter("Chương 4: Hiđrocacbon - Nhiên liệu", [
            "Bài 34: Khái niệm về hợp chất hữu cơ và hóa học hữu cơ",
            "Bài 35: Cấu tạo phân tử hợp chất hữu cơ",
            "Bài 36: Metan (CH4)",
            "Bài 37: Etilen (C2H4)",
            "Bài 38: Axetilen (C2H2)",
            "Bài 39: Benzen (C6H6)",
            "Bài 40: Dầu mỏ và khí thiên nhiên",
            "Bài 41: Nhiên liệu",
          ]),
          _buildChapter("Chương 5: Dẫn xuất Hiđrocacbon - Polime", [
            "Bài 44: Rượu Etylic (C2H5OH)",
            "Bài 45: Axit Axetic (CH3COOH)",
            "Bài 46: Mối liên hệ giữa Etilen, Rượu Etylic và Axit Axetic",
            "Bài 47: Chất béo",
            "Bài 48: Luyện tập: Rượu Etylic, Axit Axetic và Chất béo",
            "Bài 50: Glucozơ",
            "Bài 51: Saccarozơ",
            "Bài 52: Tinh bột và Xenlulozơ",
            "Bài 53: Protein",
            "Bài 54: Polime",
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
