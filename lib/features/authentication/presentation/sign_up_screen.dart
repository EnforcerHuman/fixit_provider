import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/otp_verification_screen.dart';
import 'package:fixit_provider/features/authentication/presentation/widgets/otp_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is OTPSentState) {
            print('id printed from sign up screen ${state.verificationId}');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => OtpScreen(
                      email: emailController.text,
                      password: passwordController.text,
                      id: state.verificationId,
                    )));
          } else if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Enter your email and password to Sign Up',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your phone',
                                  prefixIcon: Icon(Icons.phone),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
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
                              const SizedBox(height: 25),
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
                              const SizedBox(height: 30),
                              if (state is OtpSendingState)
                                const OtpSending(
                                  text: 'OTP SENDING...',
                                )
                              else
                                RoundButton(
                                  title: state is SignUpErrorState
                                      ? 'Resend OTP'
                                      : 'Sign Up',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<SignUpBloc>(context).add(
                                          SendOTPEvent(
                                              phoneController.text.trim()));
                                      context.read<ServiceProviderBloc>().add(
                                          UpdatePhoneNumber(
                                              phoneController.text));
                                      context.read<ServiceProviderBloc>().add(
                                          UpdateEmail(emailController.text));
                                    }
                                  },
                                ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Have an account ?'),
                                  TextButton(
                                    onPressed: () {
                                      // Handle sign in
                                    },
                                    child: Text('Sign In now'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
