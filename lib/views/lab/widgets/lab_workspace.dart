import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chemistry_simulation/providers/lab_provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LabWorkspace extends StatefulWidget {
  const LabWorkspace({super.key});

  @override
  State<LabWorkspace> createState() => _LabWorkspaceState();
}

class _LabWorkspaceState extends State<LabWorkspace> {
  YoutubePlayerController? _controller;

  void _setupController(String? videoUrl) {
    if (videoUrl == null) return;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null && _controller == null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labProvider = context.watch<LabProvider>();

    if (labProvider.currentResult?.videoUrl != null) {
      _setupController(labProvider.currentResult!.videoUrl);
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller ?? YoutubePlayerController(initialVideoId: ""),
      ),
      builder: (context, player) {
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
                  // 1. Lọ hóa chất
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBeaker(labProvider.firstChemical, "Chất 1"),
                      const Icon(Icons.add, color: Colors.grey),
                      _buildBeaker(labProvider.secondChemical, "Chất 2"),
                    ],
                  ),
                  const SizedBox(height: 30),

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
                          labProvider.currentResult!.equation.replaceAll(
                            r'$',
                            '',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 3. HIỂN THỊ PLAYER (đã được Builder bảo vệ)
                    if (labProvider.currentResult!.videoUrl != null &&
                        _controller != null)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: player,
                        ),
                      ),

                    // 4. Hiện tượng
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        labProvider.currentResult!.phenomenon,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ] else if (labProvider.firstChemical != null &&
                      labProvider.secondChemical != null)
                    const Text(
                      "Không có phản ứng xảy ra",
                      style: TextStyle(color: Colors.red),
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
      },
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
