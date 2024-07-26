import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';

class SignUpUseCase {
  final AuthRemoteDataSource remoteDataSource;

  SignUpUseCase(this.remoteDataSource);

  Future<String> signUp(String phoneNumber) async {
    try {
      String Id = await remoteDataSource.sendOTP(phoneNumber);
      print('id from use case : $Id');
      if (Id.isEmpty) {
        throw Exception('Failed to send OTP: Empty ID returned');
      }
      return Id;
    } catch (e) {
      print('Error in SignUpUseCase.signUp: $e');
      throw e; // Make sure to throw the error
    }
  }

  Future<UserCredential> verifyOTP(
    String otp,
    String verificationId,
    String email,
    String Password,
  ) async {
    try {
      return await remoteDataSource.verifyOTP(
          otp, verificationId, email, Password);
    } catch (e) {
      print('Error in SignUpUseCase.verifyOTP: $e');
      rethrow; // Re-throw the exception to be caught by the Bloc
    }
  }

  Future<void> linkEmailPassword(String email, String password) async {
    try {
      await remoteDataSource.linkEmailPassword(email, password);
    } catch (e) {
      print('Error in SignUpUseCase.linkEmailPassword: $e');
      rethrow; // Re-throw the exception to be caught by the Bloc
    }
  }
}
