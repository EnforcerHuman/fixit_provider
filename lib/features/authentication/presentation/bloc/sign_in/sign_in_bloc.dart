import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fixit_provider/features/authentication/domain/usecases/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<VerifySignIn>((event, emit) async {
      AuthRemoteDataSource auth = AuthRemoteDataSource();
      SignInUseCase signInUseCase = SignInUseCase(AuthRemoteDataSource());

      try {
        emit(SignInLoading());
        Map<String, dynamic>? user =
            await auth.login(event.email, event.password, event.context);
        print(user);
        String navigationTarget =
            await signInUseCase.handleSignInSuccesss(user!);

        emit(SignInSuccess(navigationTarget));
      } catch (e) {
        emit(SignInFailed());
      }
    });
  }
}
