import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/presentation/sign_in_scree.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: const Text('Logout'),
          onTap: () {
            SharedPreferencesHelper.setUserId('');
            SharedPreferencesHelper.setLoginStatus(false);
            SharedPreferencesHelper.setVerificationStatus(false);

            try {
              User user = FirebaseAuth.instance.currentUser!;
              user.delete();
              print('User account deleted');
            } catch (e) {
              print('Failed to delete user account: $e');
            }

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const SignInScreen()),
                (route) => false);
          },
        ),
      ),
    );
  }
}
