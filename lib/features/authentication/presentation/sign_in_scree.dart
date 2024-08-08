import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fixit_provider/features/authentication/domain/usecases/sign_in.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/forgot_password_screen.dart';
import 'package:fixit_provider/features/authentication/presentation/sign_up_screen.dart';
import 'package:fixit_provider/features/authentication/presentation/verification_pending_screen.dart';
import 'package:fixit_provider/features/authentication/presentation/widgets/otp_loading.dart';
import 'package:fixit_provider/features/booking/presentation/screens/home_screen.dart';
import 'package:fixit_provider/features/main_navigation/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String buttontext = 'Sign in';
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            if (state.navigationTarget == 'HomeScreen') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const MainScreen()),
                  (route) => false);
            } else if (state.navigationTarget == 'VerificationPendingScreen') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (ctx) => const VerificationPendingScreen()),
                  (route) => false);
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Enter your email and password to login',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your email',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: Icon(Icons.visibility_off),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ForgotPasswordScreen()));
                                  },
                                  child: const Text('Forgot Password?'),
                                ),
                              ),
                              const SizedBox(height: 20),
                              state is SignInLoading
                                  ? const OtpSending(
                                      text: 'verifying credentials....',
                                    )
                                  : RoundButton(
                                      title: buttontext,
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          //Login logic
                                          context.read<SignInBloc>().add(
                                              VerifySignIn(
                                                  SignInUseCase(
                                                      AuthRemoteDataSource()),
                                                  emailController.text,
                                                  passwordController.text,
                                                  context));
                                        }
                                      },
                                    ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('New to fixit?'),
                                  TextButton(
                                    onPressed: () {
                                      // Handle sign up
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  SignUpScreen()));
                                    },
                                    child: const Text('Sign up now'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    decoration:
                                        const BoxDecoration(color: Colors.grey),
                                    width: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).width * 0.04,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
