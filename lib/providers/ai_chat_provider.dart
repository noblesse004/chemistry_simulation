import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/services/ai_service.dart';
import '../data/models/ai_history_model.dart';
import '../data/services/reaction_service.dart'; // 1. IMPORT THÊM REACTION SERVICE

class Message {
  final String text;
  final bool isUser;
  Message({required this.text, required this.isUser});
}

class AIChatProvider with ChangeNotifier {
  final AIService _aiService = AIService();
  final List<Message> _messages = [
    Message(
      text:
          "Chào Duy! Mình là Chemmy, gia sư Hóa học của bạn. Bạn cần hỏi gì về chương trình lớp 9 không?",
      isUser: false,
    ),
  ];

  List<Message> get messages => _messages;
  bool _isTyping = false;
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Thêm tin nhắn của Duy vào giao diện
    _messages.add(Message(text: text, isUser: true));
    _isTyping = true;
    notifyListeners();

    // 2. KIỂM TRA DỮ LIỆU LOCAL TRƯỚC (Để tiết kiệm API Groq và phản hồi tức thì)
    String? localResponse = _checkLocalReaction(text);
    String finalResponse;

    if (localResponse != null) {
      finalResponse = "Dữ liệu Local: $localResponse";
    } else {
      // 3. GỌI GROQ AI (Thay cho Gemini cũ)
      finalResponse = await _aiService.getChemResponse(text);
    }

    // 4. Hiển thị câu trả lời
    _messages.add(Message(text: finalResponse, isUser: false));
    _isTyping = false;
    notifyListeners();

    // 5. Tự động lưu vào Firebase History
    _saveChatToFirebase(text, finalResponse);
  }

  // Hàm quét từ khóa để tìm phản ứng trong file local của Duy
  String? _checkLocalReaction(String userText) {
    String input = userText.toUpperCase();

    // Check cặp HCl và NaOH
    if (input.contains("HCL") && input.contains("NAOH")) {
      var res = ReactionService.checkReaction("HCl", "NaOH");
      return "${res!['equation']}\nHiện tượng: ${res['phenomenon']}";
    }

    // Check cặp BaCl2 và H2SO4
    if (input.contains("BACL2") && input.contains("H2SO4")) {
      var res = ReactionService.checkReaction("BaCl2", "H2SO4");
      return "${res!['equation']}\nHiện tượng: ${res['phenomenon']}";
    }

    return null;
  }

  Future<void> _saveChatToFirebase(String prompt, String response) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final history = AIHistoryModel(
      chatId: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: user.uid,
      userPrompt: prompt,
      aiResponse: response,
      timestamp: DateTime.now(),
    );

    try {
      await FirebaseFirestore.instance
          .collection('ai_history')
          .add(history.toMap());
    } catch (e) {
      debugPrint("Lỗi lưu chat: $e");
    }
  }
}
