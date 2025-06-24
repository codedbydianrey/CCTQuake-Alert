import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cctquake/screens/About/DEV/tutorial_video.dart';

class AboutApplication extends StatelessWidget {
  final VideoPlayerController controller;

  const AboutApplication({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth * 0.05;
    double sectionTitleFontSize = screenWidth * 0.045;
    double keyFeatureTitleFontSize = screenWidth * 0.035;
    double regularTextFontSize = screenWidth * 0.035;
    double smallTextFontSize = screenWidth * 0.033;
    double buttonFontSize = screenWidth * 0.04;

    // Adjust font sizes for smaller screens (Android 8-15)
    if (screenWidth < 100) {
      titleFontSize = screenWidth * 0.06;
      sectionTitleFontSize = screenWidth * 0.055;
      keyFeatureTitleFontSize = screenWidth * 0.045;
      regularTextFontSize = screenWidth * 0.045;
      smallTextFontSize = screenWidth * 0.043;
      buttonFontSize = screenWidth * 0.05;
    }

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.002),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 57, 6, 6),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(50, 211, 209, 209),
              blurRadius: screenWidth * 0.004,
              spreadRadius: screenWidth * 0.01,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.04,
          horizontal: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ABOUT THE APPLICATION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 219, 149, 29),
                  shadows: [
                    Shadow(
                      offset: Offset(screenWidth * 0.001, screenWidth * 0.0005),
                      blurRadius: screenWidth * 0.002,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text.rich(
                TextSpan(
                  text: 'The ',
                  style: TextStyle(
                    fontSize: regularTextFontSize,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'CCTQuake Alert ',
                      style: TextStyle(
                        fontSize: regularTextFontSize + 0.005,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 219, 149, 29),
                      ),
                    ),
                    TextSpan(
                      text:
                          'is a mobile application developed to provide safety guidelines and earthquake notifications in real time. This application assists users in staying vigilant and alert during seismic events.',
                      style: TextStyle(
                        fontSize: regularTextFontSize,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '\n\nKey Features:\n',
                      style: TextStyle(
                        fontSize: sectionTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 219, 149, 29),
                      ),
                    ),
                    TextSpan(
                      text: '\n1. ',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Real-time Push Notification\n',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 219, 149, 29),
                      ),
                    ),
                    TextSpan(
                      text:
                          r'''Notifies users when an earthquake is detected, providing alert to take precautionary measures. The application needs to be opened at least once to enable notifications, even if it's not running in the recent tasks. An internet connection is required to receive notifications. Upon opening the app, a pop-up message will display the PHIVOLCS Earthquake Intensity Scale along with infographics showing potential impacts at each intensity level.

                                ''',
                      style: TextStyle(
                        fontSize: smallTextFontSize,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '\n2. ',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Safety Guidelines',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 219, 149, 29),
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n   Provides safety guidelines on what to do before, during, and after an earthquake. City of Tagaytay Emergency Hotlines are also included. Additionally, it includes the intensity scale which you can flip to see the meaning of each intensity label displayed on the home screen (PEIS).',
                      style: TextStyle(
                        fontSize: smallTextFontSize,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n3. ',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Emergency Evacuation Map',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 219, 149, 29),
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n   Includes evacuation maps highlighting safe routes and designated areas for emergencies, with a legend for better understanding.',
                      style: TextStyle(
                        fontSize: smallTextFontSize,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n4. ',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Viewing Earthquake Analytics\n',
                      style: TextStyle(
                        fontSize: keyFeatureTitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 219, 149, 29),
                      ),
                    ),
                    TextSpan(
                      text:
                          'View earthquake data, including intensity, date, time, and PEIS value. Additionally, for analytics, you can see the number of earthquakes recorded for each selected date and their range, which can be downloaded as a PDF.',
                      style: TextStyle(
                        fontSize: smallTextFontSize,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify, 
              ),
              SizedBox(height: screenHeight * 0.1),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => TutorialVideo(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 149, 29),
                  shadowColor: Colors.black,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.10,
                    vertical: screenHeight * 0.01,
                  ),
                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Learn More',
                  style: TextStyle(
                    fontSize: buttonFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 57, 6, 6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
