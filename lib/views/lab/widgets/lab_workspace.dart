import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chemistry_simulation/providers/lab_provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:video_player/video_player.dart';

class LabWorkspace extends StatefulWidget {
  const LabWorkspace({super.key});

  @override
  State<LabWorkspace> createState() => _LabWorkspaceState();
}

class _LabWorkspaceState extends State<LabWorkspace> {
  VideoPlayerController? _videoController;
  String? _currentVideoPath;

  void _initializeVideo(String videoPath) {
    if (_currentVideoPath == videoPath) return;
    _currentVideoPath = videoPath;
    _videoController?.dispose();
    _videoController = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labProvider = context.watch<LabProvider>();

    if (labProvider.currentResult?.videoPath != null) {
      _initializeVideo(labProvider.currentResult!.videoPath!);
    } else {
      _videoController?.dispose();
      _videoController = null;
      _currentVideoPath = null;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF0D47A1), width: 1.5),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // 1. Lọ hóa chất (Giữ nguyên)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBeaker(labProvider.firstChemical, "Chất 1"),
                  const Icon(Icons.add, color: Colors.grey),
                  _buildBeaker(labProvider.secondChemical, "Chất 2"),
                ],
              ),
              const SizedBox(height: 20),

              if (labProvider.currentResult != null) ...[
                // 2. Phương trình
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                    child: Math.tex(
                      labProvider.currentResult!.equation.replaceAll(r'$', ''),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                // 3. HIỆN TƯỢNG
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "✨ Hiện tượng: ${labProvider.currentResult!.phenomenon}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                if (labProvider.currentResult!.imagePath != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        labProvider.currentResult!.imagePath!,
                        width: 260, // Kích thước bằng với Video cho đồng bộ
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text("Lỗi tải ảnh"),
                      ),
                    ),
                  ),

                // 4. KHU VỰC VIDEO
                if (_videoController != null &&
                    _videoController!.value.isInitialized)
                  Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 260,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _videoController!.value.isPlaying
                                    ? _videoController!.pause()
                                    : _videoController!.play();
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: AspectRatio(
                                    aspectRatio:
                                        _videoController!.value.aspectRatio,
                                    child: VideoPlayer(_videoController!),
                                  ),
                                ),
                                if (!_videoController!.value.isPlaying)
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Bấm xem clip thí nghiệm thực tế",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  )
                else if (labProvider.currentResult!.videoPath != null)
                  const CircularProgressIndicator(),
              ] else if (labProvider.firstChemical != null &&
                  labProvider.secondChemical != null)
                const Text(
                  "Không có phản ứng xảy ra",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                const Text(
                  "Kéo hóa chất vào đây",
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeaker(dynamic chemical, String title) {
    return Column(
      children: [
        Icon(
          Icons.science,
          size: 70,
          color: chemical != null
              ? const Color(0xFF0D47A1)
              : Colors.grey.shade300,
        ),
        const SizedBox(height: 4),
        Text(
          chemical?.name ?? title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
