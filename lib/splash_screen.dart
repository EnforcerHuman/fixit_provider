// ignore_for_file: use_build_context_synchronously

import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/presentation/sign_in_scree.dart';
import 'package:fixit_provider/features/authentication/presentation/verification_pending_screen.dart';
import 'package:fixit_provider/features/main_navigation/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedStatus();
  }

  Future<void> _checkLoggedStatus() async {
    isLogged = await SharedPreferencesHelper.getLoginStatus();
    isVerified = await SharedPreferencesHelper.getVerificationStatus();
    if (isLogged && isVerified) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const MainScreen()),
        (route) => false,
      );
    } else if (isLogged && !isVerified) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const VerificationPendingScreen()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const SignInScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/img/large_logo.png')),
    );
  }
}
