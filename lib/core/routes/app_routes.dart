import 'package:flutter/material.dart';
import '../../views/auth/auth_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/lectures/lecture_list_screen.dart';
import '../../views/lab/lab_screen.dart';
import '../../views/chat/ai_chat_screen.dart';

class AppRoutes {
  static const String auth = '/';
  static const String home = '/home';
  static const String lab = '/lab';
  static const String lectures = '/lectures';
  static const String chat = '/chat';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case lab:
        return MaterialPageRoute(builder: (_) => const LabScreen());

      case lectures:
        return MaterialPageRoute(builder: (_) => const LectureListScreen());

      case chat:
        return MaterialPageRoute(builder: (_) => const AIChatScreen());

      default:
        return _errorRoute();
    }
  }

  // Hàm xử lý khi lỗi điều hướng hoặc trang chưa phát triển
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Lỗi hệ thống'),
          backgroundColor: const Color(0xFF0D47A1),
        ),
        body: const Center(
          child: Text(
            'Tính năng này đang được Chemmy phát triển!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
