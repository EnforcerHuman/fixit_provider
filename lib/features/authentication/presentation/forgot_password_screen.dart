import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/widgets/otp_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ResetLinkSent) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Reset Link send to your email id')));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: TextFormField(
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
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  state is ResetLinkSending
                      ? const OtpSending(text: 'Sending Link')
                      : RoundButton(
                          title: 'Get Reset link',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              //Login logic
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(SentResetLink(emailController.text));
                            }
                          },
                        ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
