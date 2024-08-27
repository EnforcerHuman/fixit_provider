import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/user_status/user_status_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/sign_in_scree.dart';
import 'package:fixit_provider/features/authentication/presentation/widgets/otp_loading.dart';
import 'package:fixit_provider/features/main_navigation/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserStatusBloc, UserStatusState>(
      listener: (context, state) {
        if (state is UserVerified) {
          SharedPreferencesHelper.setVerificationStatus(true);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              color: Colors.green,
              title: 'Congrats!',
              message: 'Your Application is Approved ',
              contentType: ContentType.success,
            ),
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);
        } else if (state is UserNotVerified) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              color: Colors.green,
              title: 'Pending',
              message:
                  'Your profile verification is still under verification !',
              contentType: ContentType.help,
            ),
          ));
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocBuilder<UserStatusBloc, UserStatusState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const SignInScreen()));
                          },
                          icon: const Text('Logout'))
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/img/verification_pending.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Verification Pending!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We’ll let you know once your application is approved',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Handle button press
                        String userId =
                            await SharedPreferencesHelper.getUserId();
                        // ignore: use_build_context_synchronously
                        context
                            .read<UserStatusBloc>()
                            .add(CheckUserStatus(userId));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0), // Button color
                      ),
                      child: state is UserStatusChecking
                          ? const OtpSending(text: 'Checking user status')
                          : const Text(
                              'Check Status',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
