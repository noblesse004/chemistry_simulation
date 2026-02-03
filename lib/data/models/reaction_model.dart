class ReactionModel {
  final String id;
  final String equation; // Ví dụ: BaCl2 + H2SO4 -> BaSO4 + 2HCl
  final String phenomenon; // Hiện tượng: Kết tủa trắng, sủi bọt khí...
  final List<String> reactants; // Các chất tham gia: ["BaCl2", "H2SO4"]
  final String resultColor; // Màu sắc sản phẩm (nếu có đổi màu)
  final int xpAwarded;
  final String? videoUrl; // Điểm thưởng khi khám phá ra

  ReactionModel({
    required this.id,
    required this.equation,
    required this.phenomenon,
    required this.reactants,
    this.resultColor = 'transparent',
    this.xpAwarded = 50,
    this.videoUrl,
  });

  factory ReactionModel.fromMap(Map<String, dynamic> data) {
    return ReactionModel(
      id: data['id'] ?? '',
      equation: data['equation'] ?? '',
      phenomenon: data['phenomenon'] ?? '',
      reactants: List<String>.from(data['reactants'] ?? []),
      resultColor: data['resultColor'] ?? 'transparent',
      xpAwarded: data['xpAwarded'] ?? 50,
      videoUrl: data['videoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'equation': equation,
      'phenomenon': phenomenon,
      'reactants': reactants,
      'resultColor': resultColor,
      'xpAwarded': xpAwarded,
      'videoUrl': videoUrl,
    };
  }
}
