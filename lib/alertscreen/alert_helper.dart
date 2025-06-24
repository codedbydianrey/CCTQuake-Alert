import 'package:flutter/material.dart';

void showEarthquakeAlert(BuildContext context, String intensity,
    String timestamp, bool isAlertShowing, Function setAlertShowing) {
  if (isAlertShowing) return;

  setAlertShowing(true);

  String? imagePath;
  String additionalText;
  switch (intensity) {
    case 'I':
      imagePath = 'images/I.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.';
      break;
    case 'II':
      imagePath = 'images/II.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.';
      break;
    case 'III':
      imagePath = 'images/III.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks..';
      break;
    case 'IV':
      imagePath = 'images/IV.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.	.';
      break;
    case 'V':
      imagePath = 'images/V.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks..';
      break;
    case 'VI':
      imagePath = 'images/VI.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.	.';
      break;
    case 'VII':
      imagePath = 'images/VII.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks..';
      break;
    case 'VIII':
      imagePath = 'images/VIII.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.';
      break;
    case 'IX':
      imagePath = 'images/IX.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.';
      break;
    case 'X':
      imagePath = 'images/X.jpg';
      additionalText =
          'Be alert, drop, cover, and hold. \nBe careful of incoming aftershocks.';
      break;
    default:
      imagePath = null;
      additionalText = '';
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 126, 44, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Center(
          child: Text(
            'CCTQuake Alert',
            style: TextStyle(
              color: const Color.fromARGB(255, 237, 179, 3),
              fontWeight: FontWeight.bold,
              fontSize: 35,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (imagePath != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        imagePath,
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      children: [
                        TextSpan(text: 'An earthquake of  '),
                        TextSpan(
                            text: 'intensity  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextSpan(
                          text: intensity,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 241, 173, 0),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(text: '  was detected at $timestamp.'),
                      ],
                    ),
                  ),
                ),
                if (additionalText.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      additionalText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 206, 205, 205),
                          fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setAlertShowing(false);
              Navigator.of(context).pop();
            },
            child: Text('Close',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ),
        ],
      );
    },
  );
}
