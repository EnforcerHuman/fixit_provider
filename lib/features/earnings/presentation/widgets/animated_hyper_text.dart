import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTyperText extends StatelessWidget {
  final String text;
  const AnimatedTyperText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('ext', speed: const Duration(milliseconds: 300)),
          ],
        ),
      ),
    );
  }
}
