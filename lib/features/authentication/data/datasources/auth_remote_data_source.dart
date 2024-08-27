import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/authentication/presentation/verification_pending_screen.dart';
import 'package:flutter/material.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> sendOTP(String phone) async {
    Completer<String> completer = Completer();
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phone",
      timeout: const Duration(seconds: 40),
      verificationCompleted: (credential) {},
      verificationFailed: (e) {
        completer.completeError(e); // Complete with error
      },
      codeSent: (verificationId, responseToken) {
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    return completer.future;
  }

  // Method to verify OTP
  Future<UserCredential> verifyOTP(
      String otp, String verificationId, String email, String password) async {
    try {
      PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneCredential);

      await linkEmailPassword(email, password);

      return userCredential;
    } catch (e) {
      throw Exception('Error verifying OTP: $e');
    }
  }

  // Method to link email/password to phone auth user
  Future<void> linkEmailPassword(String email, String password) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential emailPasswordCredential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.linkWithCredential(emailPasswordCredential);
    } catch (e) {
      throw Exception('Error linking email/password: $e');
    }
  }

  //Reset password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // You can add additional logic here, such as showing a success message to the user
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      // You can handle the error here, such as showing an error message to the user
      throw errorMessage;
    } catch (e) {
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

  // Method to

  Future<Map<String, dynamic>?> login(
      String email, String password, BuildContext context) async {
    UserCredential? userCredential;
    bool? isverified;
    try {
      // Attempt to sign in with email and password
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Map<String, dynamic>? user =
          await getUserDetailsById(userCredential.user!.uid);

      if (user!['isVerified'] == true) {
        isverified = true;
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (ctx) => const VerificationPendingScreen()),
        );
      } else if (user['isVerified'] == false) {
        isverified = false;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            color: Colors.green,
            title: 'Pending',
            message: 'Your profile verification is still under verification !',
            contentType: ContentType.help,
          ),
        ));
      }
      return user;
      // If successful, navigate to the home screen
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          color: Colors.green,
          title: 'unexpected',
          message: errorMessage,
          contentType: ContentType.help,
        ),
      ));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(errorMessage)),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
    try {
      // Get a reference to the users collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('ServiceProviders');

      // Get the document with the specified user ID
      DocumentSnapshot documentSnapshot = await users.doc(userId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
