import 'package:flutter/material.dart';

class UploadFileWidget extends StatelessWidget {
  final String boxText;
  final Color color;
  final String label;
  final Function() onTap;
  const UploadFileWidget(
      {super.key,
      required this.label,
      required this.onTap,
      required this.color,
      required this.boxText});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            width: width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.upload_file, color: Colors.blue),
              label: Text(boxText, style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}
