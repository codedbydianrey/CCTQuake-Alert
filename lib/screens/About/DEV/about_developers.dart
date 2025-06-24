import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDevelopers extends StatelessWidget {
  const AboutDevelopers({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> developers = [
      {
        "name": "Christine Joy",
        "image": "images/Chirstine.png",
        "credentials": "Main Resource | Documentary II | CCTQuake Co-Creator",
        "facebook": "",
        "instagram":
            "",
        "gmail": "mailto:conejoschristine21@gmail.com"
      },
      {
        "name": "Dianrey",
        "image": "images/Dian.png",
        "credentials":
            "Main Documentary | UI/UX Designer II | Assistant Developer - CCTQuake Alert ",
        "facebook": "",
        "instagram":
            "",
        "gmail": "mailto:dianreydn@gmail.com"
      },
      {
        "name": "Antoinette",
        "image": "images/Antoinette.jpg",
        "credentials":
            "Main UI/UX Designer | \n Main Developer - CCTQuake Alert | Assistant Developer - Earthquake Detector",
        "facebook": "",
        "instagram":
            "",
        "gmail": "mailto:antoinettenadala18@gmail.com",
      },
      {
        "name": "Mafe",
        "image": "images/Mafe.png",
        "credentials":
            "Full Stack Developer | \nMain Developer - Earthquake Detector | Resource II | CCTQuake Co-Creator",
        "facebook": "",
        "instagram": "",
        "gmail": "mailto:mvicente1126@gmail.com"
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Use MediaQuery to get screen size information
          final screenWidth = MediaQuery.of(context).size.width;

          // Determine if the screen is large
          bool isLargeScreen = screenWidth > 600;

          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 52, 4, 4),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(50, 211, 209, 209),
                  blurRadius: 2.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            padding: EdgeInsets.all(constraints.maxWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: constraints.maxHeight * 0.02),
                Text(
                  'ABOUT THE DEVELOPERS',
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.06,
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
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  'Bachelor of Science in Computer Science',
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.03,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: constraints.maxWidth > 600
                        ? 16 / 9
                        : 18 / 17, // Adjust aspect ratio for larger screens
                    enlargeCenterPage: true,
                  ),
                  items: developers.map((developer) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Stack(
                            children: [
                              // Background Image
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'images/Dev_bg_.jpg'), // Static background
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Overlay for readability
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: Colors.black
                                      .withOpacity(0.3), // Dark overlay effect
                                ),
                              ),
                              // Content
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Developer Profile Picture (Separate from background)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          100.0), // Adjust the radius as needed
                                      child: Image.asset(
                                        developer["image"]!, // Profile picture
                                        height: constraints.maxHeight * 0.25,
                                        width: constraints.maxWidth * 0.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      developer["name"]!,
                                      style: TextStyle(
                                        fontSize: constraints.maxWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white, // White text for readability
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      developer["credentials"]!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: constraints.maxWidth > 600
                                              ? 12
                                              : 10, // Adjust font size for larger screens
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => launchUrl(Uri.parse(
                                              developer["facebook"]!)),
                                          child: Image.asset(
                                            'images/5.png',
                                            width: isLargeScreen ? 30 : 24,
                                            height: isLargeScreen ? 30 : 24,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () => launchUrl(Uri.parse(
                                              developer["instagram"]!)),
                                          child: Image.asset(
                                            'images/6.png',
                                            width: isLargeScreen ? 30 : 25,
                                            height: isLargeScreen ? 30 : 25,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () => launchUrl(
                                              Uri.parse(developer["gmail"]!)),
                                          child: Image.asset(
                                            'images/gmail.png',
                                            width: isLargeScreen ? 30 : 25,
                                            height: isLargeScreen ? 30 : 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }
}
