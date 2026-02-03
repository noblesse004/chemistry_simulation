import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart'; // Đảm bảo import đúng UserModel của Duy

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ĐĂNG KÝ: Tạo Auth + Tạo Profile Firestore
  Future<User?> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Khởi tạo UserModel đúng như file Duy đã gửi
        UserModel newUser = UserModel(
          uid: user.uid,
          displayName: name,
          email: email,
          totalXP: 0,
          rank: "Tập sự",
          unlockedReactions: [],
          lessonProgress: [],
        );

        // Lưu lên Firestore dùng hàm toMap() của Duy
        await _db.collection('users').doc(user.uid).set(newUser.toMap());
        await _auth.signOut();
      }
      return user;
    } catch (e) {
      print("Lỗi Đăng ký chi tiết: $e");
      return null;
    }
  }

  // ĐĂNG NHẬP: Kiểm tra tài khoản
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Lỗi Đăng nhập chi tiết: $e");
      return null;
    }
  }
}
