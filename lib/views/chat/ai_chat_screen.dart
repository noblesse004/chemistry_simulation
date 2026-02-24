import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ai_chat_provider.dart';
import 'widgets/math_text.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<AIChatProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          "Gia sư AI Chemmy",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[700],
        elevation: 2,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final msg = chatProvider.messages[index];
                return _buildChatBubble(msg);
              },
            ),
          ),
          if (chatProvider.isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chemmy đang soạn bài...",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.purple[300],
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          _buildInputArea(chatProvider),
        ],
      ),
    );
  }

  Widget _buildChatBubble(Message msg) {
    bool isUser = msg.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.purple[600] : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: MathText(
          text: msg.text,
          textColor: isUser ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInputArea(AIChatProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        10,
        16,
        30,
      ), // Padding dưới cao hơn cho iOS
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Hỏi Chemmy...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (_controller.text.trim().isNotEmpty) {
                provider.sendMessage(_controller.text);
                _controller.clear();
                Future.delayed(
                  const Duration(milliseconds: 200),
                  _scrollToBottom,
                );
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.purple[700],
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
