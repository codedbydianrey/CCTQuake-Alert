import 'package:flutter/material.dart';
import 'IntensityFlipCard.dart';

class IntensityScale extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const IntensityScale({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
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
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text.rich(
                TextSpan(
                  text: 'WHAT YOU ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: '\nNEED TO KNOW',
                      style: TextStyle(
                        fontSize: 25,
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
                      text: '!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 1),
            Expanded(
              child: ListView(
                children: [
                  IntensityFlipCard(
                    intensity: 'I',
                    description:
                        'Felt under favorable conditions. \nStill water in containers oscillates slightly.',
                    title: 'Scarcely\nPerceptible',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 0.50 - 1.49: Low Intensity',
                    icon: Icons.arrow_forward,
                  ),
                  IntensityFlipCard(
                    intensity: 'II',
                    description:
                        'Felt by a few at rest indoors. \nHanging objects sway slightly. Water in containers moves.',
                    title: 'Slightly Felt',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 1.50 - 2.49: Low Intensity',
                    icon: Icons.arrow_forward, 
                  ),
                  IntensityFlipCard(
                    intensity: 'III',
                    description:
                        'Felt indoors, especially in upper floors. Vibration like a light truck passing. Hanging objects swing moderately.\n Some experience dizziness.',
                    title: '      Weak',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 2.51 - 3.49: Low Intensity',
                    icon: Icons.arrow_forward,
                  ),
                  IntensityFlipCard(
                    intensity: 'IV',
                    description:
                        'Felt indoors by many, outdoors by few during the day. \nDishes, windows, doors disturbed;\n walls make cracking sound.',
                    title: '  Moderately  \n   Strong',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 3.50 - 4.49: Low Intensity',
                    icon: Icons.arrow_forward,
                  ),
                  IntensityFlipCard(
                    intensity: 'V',
                    description:
                        'Most feel it indoors and outdoors. Some wake up \nor run outside. Objects may fall.\n Liquids spill. Vehicles rock noticeably.',
                    title: '    Strong',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 4.50 - 5.49: Medium Intensity',
                    icon: Icons.arrow_forward,
                  ),
                  IntensityFlipCard(
                    intensity: 'VI',
                    description:
                        'Many are frightened and run outdoors. \nHeavy furniture moves. laster cracks, old \nstructures slightly damaged. Small landslides may occur.',
                    title: ' Very Strong',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 5.50 - 6.49: Medium Intensity',
                    icon: Icons.arrow_forward, 
                  ),
                  IntensityFlipCard(
                    intensity: 'VII',
                    description:
                        'Difficult to stand on upper floors.Heavy furniture topples. \nPoor structures suffer damage. Cracks appear in roads\n and walls. Landslides and liquefaction occur.',
                    title: '   Destructive',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 6.50 - 7.49: Medium Intensity',
                    icon: Icons.arrow_forward,
                  ),
                  IntensityFlipCard(
                    intensity: 'VIII',
                    description:
                        'People panic, struggling to stand. Well-built buildings \nheavily damaged.Bridges and dikes collapse. \nUtility posts and railway tracks may tilt or break.\n Landslides and rockfalls occur.',
                    title: ' Very Destructive',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 7.50 - 8.49: Medium Intensity',
                    icon: Icons.arrow_forward, 
                  ),
                  IntensityFlipCard(
                    intensity: 'IX',
                    description:
                        'People are thrown to the ground in fear.\n Most buildings collapse. Utility structures are \ndestroyed. Ground severely deformed. \nTrees violently shaken.',
                    title: ' Devastating',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 8.50 - 9.49: High Intensity',
                    icon: Icons.arrow_forward, 
                  ),
                  IntensityFlipCard(
                    intensity: 'X',
                    description:
                        'Almost all structures destroyed. Massive landslides, \nand shifts, and river course changes. Many trees toppled or uprooted.',
                    title: 'Completely \nDevastating',
                    details:
                        'PHIVOLCS Earthquake Intensity Scale:\n 9.50 - 10.0: High Intensity',
                    icon: Icons.arrow_forward, 
                  ),
                ],
              ),
            ),

            ListTile(
              title: Text.rich(
                TextSpan(
                  text: 'PHILVOCS\n',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'Philippine Institute of Volcanology and Seismology\n\n',
                      style: TextStyle(
                        fontSize: screenHeight * 0.01,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
