import 'package:cloud_firestore/cloud_firestore.dart';

class AIHistoryModel {
  final String chatId;
  final String userId;
  final String userPrompt;
  final String aiResponse;
  final DateTime timestamp;

  AIHistoryModel({
    required this.chatId,
    required this.userId,
    required this.userPrompt,
    required this.aiResponse,
    required this.timestamp,
  });

  factory AIHistoryModel.fromMap(Map<String, dynamic> data) {
    return AIHistoryModel(
      chatId: data['chatId'] ?? '',
      userId: data['userId'] ?? '',
      userPrompt: data['userPrompt'] ?? '',
      aiResponse: data['aiResponse'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'userId': userId,
      'userPrompt': userPrompt,
      'aiResponse': aiResponse,
      'timestamp': timestamp,
    };
  }
}
