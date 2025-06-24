import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorialVideo extends StatefulWidget {
  const TutorialVideo({super.key});

  @override
  State<TutorialVideo> createState() => _TutorialVideoState();
}

class _TutorialVideoState extends State<TutorialVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/Tutorial.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
            color: Color.fromARGB(255, 255, 255, 255), width: 3),
      ),
      child: Container(
        width: screenWidth * (isLandscape ? 0.8 : 0.95),
        height: screenHeight * (isLandscape ? 0.8 : 0.8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 216, 167, 75),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Text(
                  'Tutorial',
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        blurRadius: 5.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(3, 0),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Tutorial',
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              height:
                  screenHeight * (isLandscape ? 0.35 : 0.3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 178, 155, 155),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        final RenderBox box =
                            context.findRenderObject() as RenderBox;
                        final Offset localPosition =
                            box.globalToLocal(details.globalPosition);
                        final double width = box.size.width;
                        final double percentage = localPosition.dx / width;
                        final Duration position =
                            _controller.value.duration * percentage;
                        _controller.seekTo(position);
                      },
                      child: _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : const CircularProgressIndicator(),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: const Color.fromARGB(255, 75, 5, 25),
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 74, 16, 16),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: screenWidth * 0.06,
                    color: Color.fromARGB(
                        255, 239, 166, 9),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Play/Pause',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Text(
                        'This tutorial demonstrates the key features of CCTQuake Alert:\n\n'
                        '• How to navigate through different sections\n'
                        '• Understanding earthquake notifications\n'
                        '• Using the emergency evacuation map\n'
                        '• Accessing safety guidelines\n'
                        '• Viewing earthquake analytics\n\n'
                        'Watch the video for a detailed walkthrough of these features.',
                        style: TextStyle(
                          fontSize: constraints.maxWidth > 350
                              ? 16
                              : 12,
                          color: const Color.fromARGB(255, 57, 6, 6),
                          height: 1.3,
                          letterSpacing: 0.3,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _controller.pause();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close\n',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
