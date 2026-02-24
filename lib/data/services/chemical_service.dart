import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chemical_model.dart'; // Import model của Duy

class ChemicalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. Hàm đẩy 1 chất đơn lẻ
  Future<void> addChemical(ChemicalModel chemical) async {
    try {
      await _db.collection('chemicals').doc(chemical.id).set(chemical.toMap());
      print(">>> Đã đẩy ${chemical.name} lên Firebase!");
    } catch (e) {
      print(">>> Lỗi khi đẩy dữ liệu: $e");
    }
  }

  // 2. Hàm "Seed" - Đẩy nhanh một danh sách hóa chất (Dành cho Duy tạo data ban đầu)
  Future<void> seedDatabase() async {
    List<ChemicalModel> initialData = [
      ChemicalModel(
        id: 'hcl',
        name: 'Axit Clohidric',
        formula: 'HCl',
        type: 'Axit',
        hexColor: '#F5F5F5',
      ),
      ChemicalModel(
        id: 'naoh',
        name: 'Natri Hidroxit',
        formula: 'NaOH',
        type: 'Bazo',
        hexColor: '#FFFFFF',
      ),
      ChemicalModel(
        id: 'h2so4',
        name: 'Axit Sunfuric',
        formula: 'H2SO4',
        type: 'Axit',
        hexColor: '#F0F0F0',
      ),
      ChemicalModel(
        id: 'bacl2',
        name: 'Bari Clorua',
        formula: 'BaCl_2',
        type: 'Muối',
        hexColor: '#FFFFFF',
      ),
    ];

    for (var chemical in initialData) {
      await addChemical(chemical);
    }
  }
}
