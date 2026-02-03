class MissionModel {
  final String missionId;
  final String title;
  final String description;
  final bool isCompleted;
  final int rewardXP;

  MissionModel({
    required this.missionId,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.rewardXP = 100,
  });

  factory MissionModel.fromMap(Map<String, dynamic> data) {
    return MissionModel(
      missionId: data['missionId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      rewardXP: data['rewardXP'] ?? 100,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'missionId': missionId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'rewardXP': rewardXP,
    };
  }
}
