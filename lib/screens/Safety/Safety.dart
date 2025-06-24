import 'package:cctquake/screens/Safety/IntensityScale.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Guidelines.dart';

class Safety extends StatefulWidget {
  static const String id = 'safety';

  const Safety({super.key});

  @override
  _SafetyScreenState createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<Safety> {
  // Function to launch the phone dialer
  _launchDialer(String number) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: number,
    );
    try {
      await launchUrl(phoneUri);
    } catch (e) {
      print('Could not launch $phoneUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'images/safety.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      height: screenHeight * 0.08,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'images/cct.png',
                          height:
                              screenHeight * 0.05,
                        ),
                        SizedBox(
                            width: screenWidth *
                                0.02),
                        Image.asset(
                          'images/scs.png',
                          height:
                              screenHeight * 0.05,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

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
                          'Guidelines',
                          style: TextStyle(
                              fontSize:
                                  screenHeight * 0.022),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Intensity Scale',
                          style: TextStyle(
                              fontSize:
                                  screenHeight * 0.022),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.01),
                Expanded(
                  child: TabBarView(children: [
                    // Content for "Guidelines" tab
                    Guidelines(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      launchDialer: _launchDialer,
                    ),

                    // Content for "Intensity Scale" tab
                    IntensityScale(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ]),
                ),
              ],
            ),
          )
        ])));
  }
}
