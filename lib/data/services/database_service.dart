import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Cập nhật điểm XP khi học sinh học bài về Axit/Bazơ/Muối
  Future<void> updateXP(int xpToAdd) async {
    return await _db.collection('users').doc(uid).update({
      'totalXP': FieldValue.increment(xpToAdd),
    });
  }

  // Lưu phản ứng hóa học học sinh vừa khám phá được
  Future<void> saveReaction(String reactionId) async {
    return await _db.collection('users').doc(uid).update({
      'unlockedReactions': FieldValue.arrayUnion([reactionId]),
    });
  }

  // Lấy thông tin học sinh thời gian thực
  Stream<DocumentSnapshot> get userData {
    return _db.collection('users').doc(uid).snapshots();
  }
}
