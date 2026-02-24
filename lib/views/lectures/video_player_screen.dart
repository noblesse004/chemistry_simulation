import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../chat/widgets/math_text.dart'; // Dùng lại cái MathText Duy vừa làm

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String title;
  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    // Reset về màn hình dọc khi thoát
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      // Fix lỗi xoay màn hình Error 101 bằng cách dùng Builder của thư viện
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primary,
        topActions: [
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context), // NÚT QUAY LẠI DUY CẦN ĐÂY
          ),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          body: Column(
            children: [
              // 1. PHẦN VIDEO Ở TRÊN
              player,

              // 2. NỘI DUNG BÀI GIẢNG Ở DƯỚI (Cuộn được)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 30),

                      // Chèn nội dung bài giảng mẫu
                      const MathText(
                        text:
                            "Tính chất hóa học của Axit:\n"
                            "1. Tác dụng với chỉ thị màu: Làm quỳ tím hóa đỏ.\n"
                            "2. Tác dụng với kim loại: \$2HCl + Fe \\rightarrow FeCl_2 + H_2\\uparrow\$\n",
                        textColor: Colors.black87,
                      ),

                      const SizedBox(height: 20),
                      // Gợi ý của Duy: Chèn thêm một hình ảnh hoặc video nhỏ giữa bài
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Mẹo: Hãy chú ý dãy hoạt động hóa học của kim loại khi viết phương trình nhé!",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
