import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:flutter/material.dart';

class WorkDetailsScreen extends StatelessWidget {
  final BookingModel bookingDetails;

  const WorkDetailsScreen({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('FixIt'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
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
                                  // Handle chat action
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
                          _buildInfoRow(
                              'Booking Requested on', bookingDetails.createdAt),
                          // const Divider(height: 32.0),
                          // _buildInfoRow('Total', '₹20/H'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: RoundButton(
                        title: 'Accept',
                        onPressed: () async {
                          print(bookingDetails.serviceId);

                          FirebaseFirestore firebaseFirestore =
                              FirebaseFirestore.instance;

                          try {
                            if (bookingDetails.id.isNotEmpty) {
                              await firebaseFirestore
                                  .collection(
                                      'Bookings') // Corrected the collection name
                                  .doc(bookingDetails
                                      .id) // Ensure this is the correct document ID
                                  .update({'status': 'Accepted'});
                            }
                            print('Status updated to Accepted');
                          } catch (e) {
                            print('Error updating status: $e');
                          }
                        })),
                const SizedBox(width: 16.0),
                Expanded(child: RoundButton(title: 'Reject', onPressed: () {})),
              ],
            ),
          ),
        ],
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
          const SizedBox(width: 8.0), // Add spacing between label and value
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              softWrap: true,
              overflow: TextOverflow.clip, // Add ellipsis if text overflows
            ),
          ),
        ],
      ),
    );
  }
}
