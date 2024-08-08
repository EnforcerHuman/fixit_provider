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
}
