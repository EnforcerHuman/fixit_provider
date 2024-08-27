// ignore: file_names
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThreeDCardDemo extends StatefulWidget {
  const ThreeDCardDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThreeDCardDemoState createState() => _ThreeDCardDemoState();
}

class _ThreeDCardDemoState extends State<ThreeDCardDemo> {
  double _angleX = 0.0;
  double _angleY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            final size = MediaQuery.of(context).size;
            _angleY = (event.position.dx - size.width / 2) / size.width * 2;
            _angleX = (event.position.dy - size.height / 2) / size.height * 2;
          });
        },
        onExit: (event) {
          setState(() {
            _angleX = 0;
            _angleY = 0;
          });
        },
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_angleX)
            ..rotateY(_angleY),
          alignment: Alignment.center,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Text(
                    'Make things float in air',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: Text(
                    'Hover over this card to unleash the power of CSS perspective',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        const url = 'https://twitter.com/mannupaaji';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      child: Text(
                        'Try now →',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Sign-up button action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
