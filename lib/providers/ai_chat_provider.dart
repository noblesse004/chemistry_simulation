import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isUser;
  Message({required this.text, required this.isUser});
}

class AIChatProvider with ChangeNotifier {
  final List<Message> _messages = [
    Message(
      text:
          "Chào Duy! Mình là Chemmy, gia sư Hóa học của bạn. Bạn cần hỏi gì về chương trình lớp 9 không?",
      isUser: false,
    ),
  ];

  List<Message> get messages => _messages;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Thêm tin nhắn của người dùng
    _messages.add(Message(text: text, isUser: true));
    notifyListeners();

    // Giả lập AI trả lời (Sau này sẽ nối API Gemini ở đây)
    _fakeAiResponse(text);
  }

  void _fakeAiResponse(String userText) {
    Future.delayed(const Duration(seconds: 1), () {
      String response =
          "Đang kết nối API... Bạn vừa hỏi về '$userText' đúng không? Mình sẽ giải đáp ngay khi bạn cấu hình xong API Key!";
      _messages.add(Message(text: response, isUser: false));
      notifyListeners();
    });
  }
}
