import 'dart:async';
import 'package:cctquake/screens/Home/Home.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  const LoadingScreen({super.key});
  @override
  _LoadingScreen createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen> {
  bool _isLogoVisible = true;

  @override
  void initState() {
    super.initState();
    _startLoadingSequence();
  }

  void _startLoadingSequence() {
    Timer.periodic(Duration(milliseconds: 1500), (Timer timer) {
      if (!mounted) return;
      setState(() {
        _isLogoVisible = !_isLogoVisible;
      });
    });

    Future.delayed(Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Home.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/loading_bg.png', // Static background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _isLogoVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: SizedBox(
                width: 1000.0,
                height: 500.0,
                child: Image.asset(
                  'images/logo CCtquake_.png', // Blinking logo
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
