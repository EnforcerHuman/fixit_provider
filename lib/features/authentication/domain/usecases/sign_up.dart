import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';

class SignUpUseCase {
  final AuthRemoteDataSource remoteDataSource;

  SignUpUseCase(this.remoteDataSource);

  Future<String> signUp(String phoneNumber) async {
    try {
      String id = await remoteDataSource.sendOTP(phoneNumber);
      if (id.isEmpty) {
        throw Exception('Failed to send OTP: Empty ID returned');
      }
      return id;
    } catch (e) {
      rethrow;
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
      rethrow; // Re-throw the exception to be caught by the Bloc
    }
  }

  Future<void> linkEmailPassword(String email, String password) async {
    try {
      await remoteDataSource.linkEmailPassword(email, password);
    } catch (e) {
      rethrow; // Re-throw the exception to be caught by the Bloc
    }
  }
}
