import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Sử dụng đường dẫn tuyệt đối để dứt điểm lỗi đỏ
import 'package:chemistry_simulation/providers/lab_provider.dart';
import 'widgets/lab_workspace.dart';
import 'widgets/chemical_inventory.dart';

class LabScreen extends StatelessWidget {
  const LabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phòng thí nghiệm ảo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Kích hoạt logic làm mới thí nghiệm từ Provider
              context.read<LabProvider>().reset();
            },
          ),
        ],
      ),
      body: const Column(
        // Giữ nguyên Column của Duy
        children: [
          // 1. Khu vực mô phỏng phản ứng
          Expanded(flex: 3, child: LabWorkspace()),

          // 2. Tiêu đề kho hóa chất
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Kho hóa chất",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 3. Danh sách hóa chất
          Expanded(flex: 1, child: ChemicalInventory()),
        ],
      ),
    );
  }
}
