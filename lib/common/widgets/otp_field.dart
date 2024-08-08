import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatelessWidget {
  final TextEditingController? textcontroller;
  const OtpField({super.key, this.textcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 70,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: textcontroller,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), counterText: ''),
        ),
      ),
    );
  }
}
