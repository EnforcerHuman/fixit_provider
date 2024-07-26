import 'package:fixit_provider/common/widgets/otp_field.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String password;
  final String id;
  const OtpScreen({
    super.key,
    required this.email,
    required this.password,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> otpControllers =
        List.generate(6, (index) => TextEditingController());

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            context
                .read<ServiceProviderBloc>()
                .add(UpdateUserId(state.userCredential.user!.uid));
            SharedPreferencesHelper.setUserId(state.userCredential.user!.uid);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => const LocationScreen()),
                (route) => false);
          } else if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter 6-digit OTP code sent to your Phone Number',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 80, 77, 77),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return Flexible(
                        child: OtpField(textcontroller: otpControllers[index]),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RoundButton(
                    title:
                        state is OtpVerifyingState ? 'Verifying....' : 'Verify',
                    onPressed: () {
                      String otp = otpControllers
                          .map((controller) => controller.text)
                          .join();

                      BlocProvider.of<SignUpBloc>(context)
                          .add(VerifyOTPEvent(otp, id, email, password));
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Did not receive code?'),
                      TextButton(
                        onPressed: () async {
                          // Resend OTP logic
                        },
                        child: const Text('Send again'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
