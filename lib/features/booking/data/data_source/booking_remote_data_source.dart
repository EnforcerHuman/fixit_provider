import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';

class BookingRemotedataSource {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<BookingModel>> getBookings(String providerId) {
    return _firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      }).toList();
    });
  }

  Future<void> updateBookingStatus(
      String id, String status, String date) async {
    try {
      CollectionReference collectionRef =
          _firebaseFirestore.collection('Bookings');
      await collectionRef.doc(id).update({'status': status});
      if (status == 'Accepted') {
        await collectionRef.doc(id).update({'bookingDateTime': date});
      }
    } catch (e) {
      print('Failed to update booking status: $e');
    }
  }

  Future<void> updatePaymentRequest(String id, String amount) async {
    try {
      CollectionReference collectionRef =
          _firebaseFirestore.collection('Bookings');
      collectionRef
          .doc(id)
          .update({'totalPayment': amount, 'paymentStatus': 'Requested'});
    } catch (e) {
      print(e.toString());
    }
  }
}
