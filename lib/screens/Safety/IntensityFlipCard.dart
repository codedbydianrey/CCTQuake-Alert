import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class IntensityFlipCard extends StatelessWidget {
  final String intensity;
  final String description;
  final String title;
  final String details;
  final IconData icon; 

  const IntensityFlipCard({
    Key? key,
    required this.intensity,
    required this.description,
    required this.title,
    required this.details,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 80,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 100, 45, 45),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 10,
              child: Text(
                intensity,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 237, 150, 0),
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 55,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 60,
              right: 0,
              child: Center(
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
      back: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 80,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 100, 45, 45),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            details,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
