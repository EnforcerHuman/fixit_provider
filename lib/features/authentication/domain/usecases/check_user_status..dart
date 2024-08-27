
// void _startPeriodicCheck(BuildContext context) {
//     Future.doWhile(() async {
//       await Future.delayed(Duration(seconds: 30));
//       if (context.mounted) {
//         context.read<UserStatusBloc>().add(CheckUserStatusEvent());
//       }
//       return context.mounted; // Continue the loop if the widget is still mounted
//     });
//   }