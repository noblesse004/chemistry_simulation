import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chemistry_simulation/data/models/chemical_model.dart';
import 'package:chemistry_simulation/data/models/reaction_model.dart';
import 'package:chemistry_simulation/data/services/lab_service.dart';
import 'package:chemistry_simulation/data/services/reaction_service.dart';

class LabProvider with ChangeNotifier {
  final LabService _labService = LabService();

  List<ChemicalModel> availableChemicals = [];
  List<ReactionModel> allReactions = [];

  ChemicalModel? firstChemical;
  ChemicalModel? secondChemical;

  ReactionModel? currentResult;
  bool isMixing = false;

  // 1. Khởi tạo dữ liệu khi vào màn Lab
  Future<void> initLab() async {
    availableChemicals = await _labService.getChemicals();
    allReactions = await _labService.getReactions();
    notifyListeners();
  }

  // 2. Logic chọn hóa chất
  void selectChemical(ChemicalModel chemical) {
    if (firstChemical == null) {
      firstChemical = chemical;
    } else if (secondChemical == null && firstChemical!.id != chemical.id) {
      secondChemical = chemical;
      _performReaction(); // Tự động trộn khi đủ 2 chất
    }
    notifyListeners();
  }

  // 3. HÀM QUAN TRỌNG: Kiểm tra và thực hiện phản ứng
  void _performReaction() async {
    if (firstChemical == null || secondChemical == null) return;

    isMixing = true;
    notifyListeners();

    // Bước A: Ưu tiên kiểm tra logic trong ReactionService
    final staticRes = ReactionService.checkReaction(
      firstChemical!.name,
      secondChemical!.name,
    );

    if (staticRes != null) {
      currentResult = ReactionModel(
        id: "static_${firstChemical!.name}_${secondChemical!.name}",
        equation: staticRes['equation'],
        phenomenon: staticRes['phenomenon'],
        reactants: [firstChemical!.id, secondChemical!.id],
        resultColor: staticRes['color'] ?? 'transparent',
        videoUrl: staticRes['videoUrl'],
        xpAwarded: 50,
      );
    } else {
      // Bước B: Nếu code không có, mới tìm trong danh sách Firebase hello
      try {
        currentResult = allReactions.firstWhere(
          (r) =>
              r.reactants.contains(firstChemical!.id) &&
              r.reactants.contains(secondChemical!.id),
        );
      } catch (e) {
        currentResult = null;
      }
    }

    // Bước C: Nếu có phản ứng, tự động cộng điểm lên Firebase
    if (currentResult != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await awardXP(user.uid, currentResult!.xpAwarded, currentResult!.id);
      }
    }

    isMixing = false;
    notifyListeners();
  }

  // 4. Hàm cộng điểm XP vào Firebase
  Future<void> awardXP(String userId, int xpAmount, String reactionId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      final snapshot = await userRef.get();
      if (!snapshot.exists) return;

      final data = snapshot.data() as Map<String, dynamic>;
      final unlocked = List<String>.from(data['unlockedReactions'] ?? []);

      // Chỉ cộng điểm nếu phản ứng này học sinh chưa từng làm
      if (!unlocked.contains(reactionId)) {
        await userRef.update({
          'totalXP': FieldValue.increment(xpAmount),
          'unlockedReactions': FieldValue.arrayUnion([reactionId]),
        });
        debugPrint(">>> Firebase: Da cong $xpAmount XP cho user $userId");
      }
    } catch (e) {
      debugPrint('Lỗi awardXP: $e');
    }
  }

  // 5. Reset bàn thí nghiệm
  void reset() {
    firstChemical = null;
    secondChemical = null;
    currentResult = null;
    isMixing = false;
    notifyListeners();
  }
}
