import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chemical_model.dart';
import '../models/reaction_model.dart';

class LabService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lấy danh sách hóa chất (Axit, Bazơ, Muối) từ Firestore
  Future<List<ChemicalModel>> getChemicals() async {
    var snapshot = await _db.collection('chemicals').get();
    return snapshot.docs
        .map((doc) => ChemicalModel.fromMap(doc.data()))
        .toList();
  }

  // Lấy danh sách các phản ứng đã được cấu hình sẵn
  Future<List<ReactionModel>> getReactions() async {
    var snapshot = await _db.collection('reactions').get();
    return snapshot.docs
        .map((doc) => ReactionModel.fromMap(doc.data()))
        .toList();
  }
}
