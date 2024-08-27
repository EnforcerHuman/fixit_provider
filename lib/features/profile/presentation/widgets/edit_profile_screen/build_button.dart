import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:flutter/material.dart';

Widget buildButton(Function() onPressed) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: RoundButton(
      title: 'Update',
      onPressed: onPressed,
    ),
  );
}
