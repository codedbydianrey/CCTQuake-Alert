import 'package:cctquake/screens/About/DEV/about_developers.dart';
import 'package:cctquake/screens/About/DEV/about_application.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  static const String id = 'about';

  const About({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<About> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/video/Tutorial.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/about_bckg.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.2),

                  // TabBar
                  TabBar(
                    labelColor: const Color.fromARGB(255, 41, 4, 4),
                    unselectedLabelColor:
                        const Color.fromARGB(255, 146, 145, 145),
                    indicatorColor: const Color.fromARGB(255, 41, 4, 4),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'About Application',
                            style: TextStyle(
                                fontSize: screenHeight *
                                    0.02), 
                          ),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'About Developers',
                            style: TextStyle(
                                fontSize: screenHeight *
                                    0.02),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  Expanded(
                    child: TabBarView(
                      children: [
                        AboutApplication(controller: _controller),
                        const AboutDevelopers(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
