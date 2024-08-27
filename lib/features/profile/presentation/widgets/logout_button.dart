import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final Function() onTap;
  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.exit_to_app, color: Colors.red),
        title: const Text('Logout', style: TextStyle(color: Colors.red)),
        onTap: onTap);
  }
}
