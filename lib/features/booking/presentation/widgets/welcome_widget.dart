import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Back', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Text('Melbin', style: TextStyle(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
