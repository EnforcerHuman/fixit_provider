import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fixit_provider/features/authentication/domain/usecases/sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    // Handle SendOTPEvent
    on<SendOTPEvent>((event, emit) async {
      AuthRemoteDataSource auth = AuthRemoteDataSource();
      SignUpUseCase signUpUseCase = SignUpUseCase(auth);
      emit(OtpSendingState());
      try {
        String verificationId = await signUpUseCase.signUp(event.phone);
        emit(OTPSentState(verificationId));
      } catch (e) {
        emit(SignUpErrorState(e.toString()));
      }
    });
    on<VerifyOTPEvent>((event, emit) async {
      // Handle OTP verification
      emit(OtpVerifyingState());
      try {
        // Perform OTP verification
        AuthRemoteDataSource auth = AuthRemoteDataSource();
        SignUpUseCase signUpUseCase = SignUpUseCase(auth);
        // UserCredential userCredential =
        UserCredential usercredential = await signUpUseCase.verifyOTP(
          event.otp,
          event.verificationId,
          event.email,
          event.password,
        );
        emit(SignUpSuccessState(
            usercredential)); // Emit state for successful verification
      } catch (e) {
        emit(SignUpErrorState(
            e.toString())); // Emit state for error during verification
      }
    });

    on<LinkEmailPasswordEvent>((event, emit) async {
      // Handle linking email/password
    });
  }
}
