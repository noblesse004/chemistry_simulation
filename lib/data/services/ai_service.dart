import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  final String _apiKey = dotenv.env['GROQ_API_KEY'] ?? '';

  // 2. Endpoint chuẩn của Groq Cloud
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  Future<String> getChemResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
          "messages": [
            {
              "role": "system",
              "content":
                  "Bạn là Chemmy, gia sư ảo của ứng dụng Chemistry Hub. "
                  "Bạn là chuyên gia về Hóa học vô cơ lớp 9, đặc biệt là Axit, Bazơ và Muối. "
                  "Hãy trả lời ngắn gọn, dễ hiểu và luôn kèm theo phương trình hóa học nếu có. "
                  "Sử dụng LaTeX cho công thức hóa học (ví dụ: \$H_2SO_4\$). "
                  "Nếu học sinh hỏi ngoài phạm vi hóa học, hãy khéo léo từ chối.",
            },
            {"role": "user", "content": prompt},
          ],
          "temperature": 0.7,
          "max_tokens": 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        return 'Lỗi từ Groq (${response.statusCode}): ${response.body}';
      }
    } catch (e) {
      return 'Lỗi kết nối rồi Duy ơi: $e';
    }
  }
}
