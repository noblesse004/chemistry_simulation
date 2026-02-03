import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  // THAY THẾ 'YOUR_API_KEY' bằng mã Duy lấy từ Google AI Studio
  static const String _apiKey = 'YOUR_API_KEY';

  final GenerativeModel _model;

  AIService()
    : _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _apiKey,
        // Thiết lập "Hệ tư tưởng" cho AI để bám sát đề tài Vô cơ lớp 9
        systemInstruction: Content.system(
          'Bạn là Chemmy, gia sư ảo của ứng dụng Chemistry Hub. '
          'Bạn là chuyên gia về Hóa học vô cơ lớp 9, đặc biệt là Axit, Bazơ và Muối. '
          'Hãy trả lời ngắn gọn, dễ hiểu và luôn kèm theo phương trình hóa học nếu có. '
          'Nếu học sinh hỏi ngoài phạm vi hóa học, hãy khéo léo từ chối.',
        ),
      );

  // Hàm gửi tin nhắn và nhận phản hồi
  Future<String> getChemResponse(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      return response.text ?? 'Chemmy đang bận suy nghĩ một chút, thử lại nhé!';
    } catch (e) {
      return 'Lỗi kết nối rồi Duy ơi: $e';
    }
  }
}
