import 'package:fixit_provider/common/color_extension.dart';
import 'package:flutter/material.dart';

class AuthentiactionOptiions extends StatefulWidget {
  final Function() ongoogleclick;
  final Function() facebookclick;

  const AuthentiactionOptiions(
      {super.key, required this.ongoogleclick, required this.facebookclick});

  @override
  State<AuthentiactionOptiions> createState() => _AuthentiactionOptiionsState();
}

class _AuthentiactionOptiionsState extends State<AuthentiactionOptiions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Tcolor.gray.withOpacity(0.5),
                ),
              ),
              Text(
                "  Or  ",
                style: TextStyle(color: Tcolor.black, fontSize: 12),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Tcolor.gray.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Google sign in
                  widget.ongoogleclick();
                },
                icon: Image.asset('assets/img/Google_logo.png'),
                label: const Text('Google'),
              ),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Handle Facebook sign in
              //     widget.facebookclick();
              //   },
              //   icon: Image.asset("assets/img/facebook_logo.png"),
              //   label: Text('Facebook'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
