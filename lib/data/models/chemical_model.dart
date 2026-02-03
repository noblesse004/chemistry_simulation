class ChemicalModel {
  final String id;
  final String name; // Tên: Axit Sunfuric
  final String formula; // Công thức: H2SO4
  final String type; // Phân loại: Axit, Bazo, Muoi, Chi thi
  final String hexColor; // Màu sắc hiển thị trong ống nghiệm

  ChemicalModel({
    required this.id,
    required this.name,
    required this.formula,
    required this.type,
    this.hexColor = '#FFFFFF', // Mặc định là không màu (trắng)
  });

  factory ChemicalModel.fromMap(Map<String, dynamic> data) {
    return ChemicalModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      formula: data['formula'] ?? '',
      type: data['type'] ?? 'Muối',
      hexColor: data['hexColor'] ?? '#FFFFFF',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'formula': formula,
      'type': type,
      'hexColor': hexColor,
    };
  }
}
