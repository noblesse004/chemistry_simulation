class UserModel {
  final String uid;
  final String displayName;
  final String email;

  // Các thuộc tính chuyên biệt cho Chemistry Hub
  final int totalXP; // Điểm kinh nghiệm tích lũy
  final List<String>
  unlockedReactions; // Lưu các phản ứng đã tìm ra (VD: "HCl_NaOH")
  final List<String> lessonProgress; // ID các bài giảng đã hoàn thành
  final String rank; // Danh hiệu (VD: "Tập sự", "Nhà hóa học nhí")

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.totalXP = 0,
    this.unlockedReactions = const [],
    this.lessonProgress = const [],
    this.rank = "Tập sự",
  });

  // Chuyển Map từ Firestore thành Object Flutter
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      displayName: data['displayName'] ?? 'Học sinh',
      email: data['email'] ?? '',
      totalXP: data['totalXP'] ?? 0,
      unlockedReactions: List<String>.from(data['unlockedReactions'] ?? []),
      lessonProgress: List<String>.from(data['lessonProgress'] ?? []),
      rank: data['rank'] ?? 'Tập sự',
    );
  }

  // Chuyển Object thành Map để đẩy lên Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'totalXP': totalXP,
      'unlockedReactions': unlockedReactions,
      'lessonProgress': lessonProgress,
      'rank': rank,
    };
  }
}
