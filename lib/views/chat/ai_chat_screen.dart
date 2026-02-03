import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/ai_chat_provider.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<AIChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gia sư AI Chemmy"),
        backgroundColor: Colors.purple, // Màu tím đặc trưng cho AI
      ),
      body: Column(
        children: [
          // Danh sách tin nhắn
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final msg = chatProvider.messages[index];
                return _buildChatBubble(msg);
              },
            ),
          ),

          // Thanh nhập liệu
          _buildInputArea(chatProvider),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Message msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: msg.isUser ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(15).copyWith(
            bottomRight: msg.isUser
                ? const Radius.circular(0)
                : const Radius.circular(15),
            bottomLeft: msg.isUser
                ? const Radius.circular(15)
                : const Radius.circular(0),
          ),
        ),
        child: Text(
          msg.text,
          style: TextStyle(color: msg.isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildInputArea(AIChatProvider provider) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Hỏi Chemmy về hóa học...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.purple),
            onPressed: () {
              provider.sendMessage(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
