import 'package:flutter/material.dart';

class EmergencyHotlines extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Function(String) launchDialer;

  const EmergencyHotlines({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.launchDialer,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final isMediumScreen =
            constraints.maxWidth >= 600 && constraints.maxWidth < 900;

        final iconSize = isSmallScreen
            ? screenHeight * 0.025
            : isMediumScreen
                ? screenHeight * 0.03
                : screenHeight * 0.035;

        final fontSize = isSmallScreen
            ? screenHeight * 0.013
            : isMediumScreen
                ? screenHeight * 0.016
                : screenHeight * 0.018;

        final verticalSpacing = isSmallScreen
            ? screenHeight * 0.015
            : isMediumScreen
                ? screenHeight * 0.02
                : screenHeight * 0.025;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                _buildEmergencyContactSection(
                  'CDRRMO',
                  ['(046) 483-0446', '(0961) 828-5952', '(0956) 003-4681'],
                  fontSize,
                  iconSize,
                  verticalSpacing,
                  isSmallScreen,
                ),
                _buildSingleContact(
                  'OSPITAL NG TAGAYTAY',
                  '(046) 888-9510',
                  fontSize,
                  iconSize,
                  verticalSpacing,
                  isSmallScreen,
                ),
                _buildEmergencyContactSection(
                  'PNP',
                  [
                    '(046) 413-1282',
                    '(0915) 913-7693',
                    '(0998) 967-3352',
                    '(0975) 719-1413',
                    '(0970) 288-5669'
                  ],
                  fontSize,
                  iconSize,
                  verticalSpacing,
                  isSmallScreen,
                ),
                _buildEmergencyContactSection(
                  'BFP',
                  ['(046) 483-1993', '(0942) 989-8495'],
                  fontSize,
                  iconSize,
                  verticalSpacing,
                  isSmallScreen,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'CCT DRRMO OFFICERS :',
                  style: TextStyle(
                    fontSize: isSmallScreen
                        ? screenHeight * 0.02
                        : screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 237, 150, 0),
                    shadows: const [
                      Shadow(
                        offset: Offset(0.3, 0.2),
                        blurRadius: 1.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                _buildSingleContact(
                  'Eduardo S. Panulin (VPASS)',
                  '(+63) 951-237-7769',
                  fontSize,
                  iconSize,
                  verticalSpacing,
                  isSmallScreen,
                ),
                _buildSingleContact(
                  'Jennifer M. Abellana (VPAA)',
                  '(+63) 908-283-7908',
                  fontSize,
                  iconSize,
                  verticalSpacing,
                  isSmallScreen,
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmergencyContactSection(
    String title,
    List<String> phoneNumbers,
    double fontSize,
    double iconSize,
    double verticalSpacing,
    bool isSmallScreen,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: verticalSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * (isSmallScreen ? 0.02 : 0.03),
        vertical: screenHeight * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.01),
            child: Text(
              "$title :",
              style: TextStyle(
                fontSize: fontSize * 1.2,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 57, 6, 6),
              ),
            ),
          ),
          ...phoneNumbers.map((phone) =>
              _buildPhoneNumberRow(phone, fontSize, iconSize, isSmallScreen)),
        ],
      ),
    );
  }

  Widget _buildSingleContact(
    String title,
    String phoneNumber,
    double fontSize,
    double iconSize,
    double verticalSpacing,
    bool isSmallScreen,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: verticalSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * (isSmallScreen ? 0.02 : 0.03),
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        children: [
          Icon(
            Icons.phone,
            color: const Color.fromARGB(255, 57, 6, 6),
            size: iconSize,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: GestureDetector(
              onTap: () => launchDialer(phoneNumber),
              child: RichText(
                text: TextSpan(
                  text: '$title: ',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: phoneNumber,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberRow(
    String phoneNumber,
    double fontSize,
    double iconSize,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.01),
      child: Row(
        children: [
          Icon(
            Icons.phone,
            color: const Color.fromARGB(255, 57, 6, 6),
            size: iconSize * 0.9,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: GestureDetector(
              onTap: () => launchDialer(phoneNumber),
              child: Text(
                phoneNumber,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
