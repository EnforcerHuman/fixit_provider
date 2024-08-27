import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';

class SignInUseCase {
  final AuthRemoteDataSource remoteDataSource;

  SignInUseCase(this.remoteDataSource);

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  Future<String> handleSignInSuccesss(Map<String, dynamic> user) async {
    await SharedPreferencesHelper.setLoginStatus(true);
    await SharedPreferencesHelper.setVerificationStatus(user['isVerified']);
    await SharedPreferencesHelper.setUserId(user['id']);

    if (user['isVerified'] == true) {
      return 'HomeScreen';
    } else {
      return 'VerificationPendingScreen';
    }
  }
}
