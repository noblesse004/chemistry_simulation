import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showError(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Icons.hub_outlined,
                size: 200,
                color: Color(0xFF0D47A1),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: -40,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.biotech, size: 150, color: Color(0xFF0D47A1)),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo & Title
                  const Icon(
                    Icons.science_rounded,
                    size: 90,
                    color: Color(0xFF0D47A1),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Chemistry Hub",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const Text(
                    "Hỗ trợ học tập Hóa vô cơ lớp 9",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        if (!isLogin)
                          _buildTextField(
                            "Họ và tên",
                            Icons.person_outline,
                            nameController,
                          ),
                        if (!isLogin) const SizedBox(height: 16),
                        _buildTextField(
                          "Email học tập",
                          Icons.email_outlined,
                          emailController,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          "Mật khẩu",
                          Icons.lock_outline,
                          passwordController,
                          isObscure: true,
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _handleAuth,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D47A1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    isLogin ? "ĐĂNG NHẬP" : "TẠO TÀI KHOẢN",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => setState(() => isLogin = !isLogin),
                    child: Text(
                      isLogin
                          ? "Chưa có tài khoản? Đăng ký ngay"
                          : "Đã có tài khoản? Đăng nhập",
                    ),
                  ),

                  const SizedBox(height: 40),
                  const Opacity(
                    opacity: 0.5,
                    child: Text(
                      "Mẹo: Axit làm quỳ tím chuyển sang màu đỏ!",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAuth() async {
    if (emailController.text.isEmpty || passwordController.text.length < 6) {
      _showError("Vui lòng nhập đúng Email và Mật khẩu (>= 6 ký tự)");
      return;
    }
    setState(() => isLoading = true);
    try {
      if (isLogin) {
        var user = await _authService.signInWithEmail(
          emailController.text,
          passwordController.text,
        );
        if (user != null) {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else {
          _showError("Sai tài khoản hoặc mật khẩu rồi Duy ơi!");
        }
      } else {
        var user = await _authService.registerWithEmail(
          emailController.text.trim(),
          passwordController.text.trim(),
          nameController.text.trim(),
        );
        if (user != null) {
          if (!mounted) return;
          _showError(
            "Đăng ký thành công! Duy hãy đăng nhập lại nhé.",
            isSuccess: true,
          );
          setState(() {
            isLogin = true;
            passwordController.clear();
          });
        }
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget _buildTextField(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isObscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF0D47A1), size: 20),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
