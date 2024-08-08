// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
// import 'package:fixit_provider/features/authentication/presentation/sign_in_scree.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           child: const Text('Logout'),
//           onTap: () {
//             SharedPreferencesHelper.setUserId('');
//             SharedPreferencesHelper.setLoginStatus(false);
//             SharedPreferencesHelper.setVerificationStatus(false);

//             try {
//               User user = FirebaseAuth.instance.currentUser!;
//               user.delete();
//               print('User account deleted');
//             } catch (e) {
//               print('Failed to delete user account: $e');
//             }

//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (ctx) => const SignInScreen()),
//                 (route) => false);
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/data/data_source/booking_remote_data_source.dart';
import 'package:fixit_provider/features/booking/domain/usecases/booking_use_case.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back, Melbin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bookings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            BookingCard(
              clientName: 'Mr. John',
              date: 'Tomorrow, 10:00 AM',
            ),
            SizedBox(height: 16),
            Text(
              'Messages',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            MessageCard(
              senderName: 'Mr. John',
              message: '16.04 - Tomorrow, 10:00 AM',
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavItem(icon: Icons.home, label: 'Home'),
                BottomNavItem(icon: Icons.schedule, label: 'Schedule'),
                BottomNavItem(icon: Icons.message, label: 'Messages'),
                BottomNavItem(icon: Icons.person, label: 'Profile'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String clientName;
  final String date;

  BookingCard({required this.clientName, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(clientName),
        subtitle: Text(date),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final String senderName;
  final String message;

  MessageCard({required this.senderName, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(senderName),
        subtitle: Text(message),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () async {
          print('tapped');
          // BookingUseCase bookingUseCase = BookingUseCase();
          // await bookingUseCase.getAcceptedBooking("2024-08-24");
        },
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  BottomNavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
