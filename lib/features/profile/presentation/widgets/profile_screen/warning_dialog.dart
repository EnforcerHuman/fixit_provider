import 'package:flutter/material.dart';

void showWarningBox(BuildContext context, Function() onSubmitted) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Do you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: onSubmitted,
            child: const Text('OK'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ],
      );
    },
  );
}
