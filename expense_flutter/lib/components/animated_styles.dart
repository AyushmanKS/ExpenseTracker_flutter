import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// ignore: must_be_immutable
class BottomTitlesStyle extends StatelessWidget {
  BottomTitlesStyle({required this.dayName, super.key});
  String dayName;

  @override
  Widget build(BuildContext context) {
    // Colors for 'BottomTitles'
    const bottomTitlesColors = [
      Colors.purple,
      Colors.black,
      Colors.black,
      Colors.yellowAccent,
      Colors.yellow,
      Colors.blue,
      Colors.purpleAccent,
    ];
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          dayName,
          textStyle: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
          ),
          colors: bottomTitlesColors,
          speed: const Duration(milliseconds: 700),
        ),
      ],
      totalRepeatCount: 100,
    );
  }
}
