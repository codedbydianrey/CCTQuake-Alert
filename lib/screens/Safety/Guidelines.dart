import 'package:flutter/material.dart';
import 'EmergencyHotlines.dart';

class Guidelines extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Function(String) launchDialer;

  const Guidelines({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.launchDialer,
  });

  @override
  Widget build(BuildContext context) {
    double titleFontSize = screenHeight * 0.02;
    double headingFontSize = screenHeight * 0.03;
    double normalFontSize = screenHeight * 0.025;
    double smallFontSize = screenHeight * 0.01;

    if (screenHeight < 600) {
      titleFontSize = screenHeight * 0.025;
      headingFontSize = screenHeight * 0.035;
      normalFontSize = screenHeight * 0.03;
      smallFontSize = screenHeight * 0.015;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), 
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 57, 6, 6),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(50, 211, 209, 209),
                blurRadius: 2.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'WHAT ',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'TO DO',
                        style: TextStyle(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 237, 150, 0),
                          shadows: [
                            Shadow(
                              offset: Offset(0.3, 0.2),
                              blurRadius: 1.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      TextSpan(
                        text: ' BEFORE\n AN EARTHQUAKE?',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.17,
                  ),
                  Positioned(
                    top: -screenHeight * 0.14,
                    right: -screenWidth * 0.38,
                    child: Image.asset(
                      'images/Before_Earthquake.jpg',
                      width: screenWidth * 0.80,
                      height: screenHeight * 0.70,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.28),
              ListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'WHAT ',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'TO DO',
                        style: TextStyle(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 237, 150, 0),
                          shadows: [
                            Shadow(
                              offset: Offset(0.3, 0.2),
                              blurRadius: 1.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      TextSpan(
                        text: ' DURING\n AN EARTHQUAKE?',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.17,
                  ),
                  Positioned(
                    top: -screenHeight * 0.14,
                    right: -screenWidth * 0.38,
                    child: Image.asset(
                      'images/During_Earthquake.jpg',
                      width: screenWidth * 0.77,
                      height: screenHeight * 0.70,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.28),
              ListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'WHAT ',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'TO DO',
                        style: TextStyle(
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 237, 150, 0),
                          shadows: [
                            Shadow(
                              offset: Offset(0.3, 0.2),
                              blurRadius: 1.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      TextSpan(
                        text: ' AFTER\n AN EARTHQUAKE?',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.17,
                  ),
                  Positioned(
                    top: -screenHeight * 0.14,
                    right: -screenWidth * 0.38,
                    child: Image.asset(
                      'images/After_Earthquake.jpg',
                      width: screenWidth * 0.77,
                      height: screenHeight * 0.70,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.30),
              ListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'PHILVOCS\n',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Philippine Institute of Volcanology and Seismology\n\n',
                        style: TextStyle(
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'City of Tagaytay',
                style: TextStyle(
                  fontSize: normalFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 237, 150, 0),
                  shadows: [
                    Shadow(
                      offset: Offset(0.3, 0.2),
                      blurRadius: 1.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Text(
                'Emergency Hotlines:',
                style: TextStyle(
                  fontSize: normalFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 237, 150, 0),
                  shadows: [
                    Shadow(
                      offset: Offset(0.3, 0.2),
                      blurRadius: 1.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              EmergencyHotlines(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                launchDialer: launchDialer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
