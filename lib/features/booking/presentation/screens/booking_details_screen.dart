import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/request_status_bloc/request_status_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/custom_calender.dart';
import 'package:fixit_provider/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit_provider/features/chat/data/models/conversation_model.dart';
import 'package:fixit_provider/features/chat/data/models/message_model.dart';
import 'package:fixit_provider/features/main_navigation/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class WorkDetailsScreen extends StatelessWidget {
  final BookingModel bookingDetails;
  final bool isUpcoming;
  const WorkDetailsScreen(
      {super.key, required this.bookingDetails, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.DAY;
    return BlocListener<RequestStatusBloc, RequestStatusState>(
      listener: (context, state) {
        if (state is RequestAccepted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const MainScreen()),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Request succesfully updated'),
          ));
        }
        if (state is RequestRejected) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const MainScreen()),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Request succesfully updated'),
          ));
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Work Details',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 24.0,
                                  backgroundColor: Colors.grey,
                                  child: Text('E'),
                                ),
                                const SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookingDetails.userName,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      bookingDetails.paymentStatus,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.chat_bubble_outline),
                                  onPressed: () {
                                    showWarningBox(context, bookingDetails);
                                  },
                                ),
                              ],
                            ),
                            const Divider(height: 32.0),
                            _buildInfoRow(
                                'Work Required', bookingDetails.serviceName),
                            _buildInfoRow('Price', '₹20/H'),
                            _buildInfoRow('Material', 'Not Added'),
                            const Divider(height: 32.0),
                            _buildInfoRow('Address',
                                bookingDetails.address.completeAddress),
                            _buildInfoRow(
                                'Booking Date', bookingDetails.bookingDateTime),
                            _buildInfoRow('Booking Requested on',
                                bookingDetails.createdAt),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          bookingDetails.workDetails,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isUpcoming == false
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: RoundButton(
                                title: 'Accept',
                                onPressed: () async {
                                  // print(bookingDetails.serviceId);
                                  showWarningDialog(context, () {
                                    // updateBookingStatusUsecases.acceptBooking(
                                    //     bookingDetails.id, date);
                                    BlocProvider.of<RequestStatusBloc>(context)
                                        .add(AcceptBooking(date,
                                            bookingDetails.id, 'Accepted'));
                                  }, (DateRangePickerSelectionChangedArgs
                                      args) {
                                    if (args.value is DateTime) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(args.value);
                                      date = formattedDate;
                                    }
                                  });
                                })),
                        const SizedBox(width: 16.0),
                        Expanded(
                            child: RoundButton(
                                title: 'Reject',
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Reject Booking'),
                                          content: const Text(
                                              'Please review  request  details before cancelling'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<RequestStatusBloc>()
                                                      .add(RejectBooking(
                                                          date,
                                                          bookingDetails.id,
                                                          'Rejected'));
                                                },
                                                child: const Text('Confirm')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('cancel'))
                                          ],
                                        );
                                      });
                                })),
                      ],
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              softWrap: true,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}

void showWarningDialog(BuildContext context, Function() onPressed,
    Function(DateRangePickerSelectionChangedArgs args) ondatechanged) {
  late String date;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose  Prefferd Date'),
        content: SizedBox(
          width: 300, // Adjust width as needed
          height: 300, // Adjust height as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: CustomCalendar(
                  onDateChanged: ondatechanged,
                ),
              ),
              const SizedBox(height: 16), //
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Proceed'),
            onPressed: onPressed,
            // () {
            //   Navigator.of(context).pop();
            // },
          ),
        ],
      );
    },
  );
}

void showWarningBox(BuildContext context, BookingModel bookingDetails) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController textController = TextEditingController();

      return AlertDialog(
        title: Text('Warning'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please enter the required information:'),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter your text here',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle the button press
              String enteredText = textController.text;

              final message = MessageModel(
                  id: '${bookingDetails.userId}${bookingDetails.serviceProviderId}',
                  senderId: '1234',
                  text: enteredText,
                  timestamp: DateTime.now());
              final conversation = ConversationModel(
                  providerName: bookingDetails.serviceProviderName,
                  userName: bookingDetails.userName,
                  id: message.id,
                  participants: [
                    bookingDetails.userId,
                    bookingDetails.serviceProviderId
                  ],
                  lastMessage: message);
              FirebaseChatDatasource firebaseChatDatasource =
                  FirebaseChatDatasource();
              firebaseChatDatasource.sendMessage(conversation, message,
                  'Melbin', bookingDetails.serviceProviderName);
              print(
                  'Entered text: $enteredText'); // You can process the text here
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}
