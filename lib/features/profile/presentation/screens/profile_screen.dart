import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/presentation/sign_in_scree.dart';
import 'package:fixit_provider/features/profile/presentation/bloc/booking_summary_bloc/booking_summary_bloc.dart';
import 'package:fixit_provider/features/profile/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:fixit_provider/features/profile/presentation/screens/about_us_screen.dart';
import 'package:fixit_provider/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:fixit_provider/features/profile/presentation/screens/feedback_screen.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/logout_button.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/profile_screen/profie_option.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/profile_screen/profile_header.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/profile_screen/statitics.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/profile_screen/warning_dialog.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeBlocs(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileHeader(),
              const SizedBox(height: 24),
              buildStatistics(),
              const SizedBox(height: 24),
              _buildProfileInformation(context),
              const SizedBox(height: 16),
              _buildInformationSection(context),
              const SizedBox(height: 16),
              _buildGeneralPreferences(context),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeBlocs(BuildContext context) {
    context.read<ServiceProviderDetailsBloc>().add(GetServiceProviderData());
    context.read<BookingSummaryBloc>().add(LoadBookingOverview());
  }

  Widget _buildProfileInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Profile information'),
        ProfileOption(
          icon: Icons.edit,
          title: 'Edit Profile',
          onTap: () => _navigateTo(context, EditProfileScreen()),
        ),
      ],
    );
  }

  Widget _buildInformationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Information Section'),
        ProfileOption(
          icon: Icons.payment,
          title: 'About us',
          onTap: () => _navigateTo(context, const AboutUsScreen()),
        ),
        ProfileOption(
          icon: Icons.event_busy,
          title: 'Feedback',
          onTap: () => _navigateTo(context, ReviewForm()),
        ),
      ],
    );
  }

  Widget _buildGeneralPreferences(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'General Preferences'),
        LogoutButton(onTap: () => _handleLogout(context)),
      ],
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen));
  }

  void _handleLogout(BuildContext context) {
    showWarningBox(context, () {
      SharedPreferencesHelper.setLoginStatus(false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );
    });
  }
}
