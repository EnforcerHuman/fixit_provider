import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';

class EarningsBookingDataSource {
  final FirebaseFirestore firebaseFirestore;

  EarningsBookingDataSource(this.firebaseFirestore);
  Stream<List<BookingModel>> getBookings(String providerId) {
    return FirebaseFirestore.instance
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(docSnapshot.data(), docSnapshot.id);
      }).toList();
    });
  }

  Stream<List<BookingModel>> getMonthlyBookings(
      String providerId, int month, int year) {
    String startDate = DateTime(year, month, 1).toIso8601String();
    String endDate = DateTime(year, month + 1, 1).toIso8601String();
    return firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .where('status', isEqualTo: 'Completed')
        .where('bookingDateTime', isGreaterThanOrEqualTo: startDate)
        .where('bookingDateTime', isLessThan: endDate)
        .orderBy('bookingDateTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(docSnapshot.data(), docSnapshot.id);
      }).toList();
    });
  }

  Stream<List<BookingModel>> getYearlyBookings(String providerId, int year) {
    return firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .where('status', isEqualTo: 'Completed')
        .where('bookingDateTime', isGreaterThanOrEqualTo: DateTime(year, 1, 1))
        .where('bookingDateTime', isLessThanOrEqualTo: DateTime(year + 1, 1, 1))
        .orderBy('bookingDateTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(docSnapshot.data(), docSnapshot.id);
      }).toList();
    });
  }

  Stream<List<BookingModel>> getAllBookings(String providerId) {
    return firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .orderBy('bookingDateTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(docSnapshot.data(), docSnapshot.id);
      }).toList();
    });
  }

  Stream<List<BookingModel>> getDailyBookings(
    String providerId,
  ) {
    // Create start and end dates for the day
    // String startDate =
    //     DateTime(date.year, date.month, date.day).toIso8601String();
    // String endDate =
    //     DateTime(date.year, date.month, date.day + 1).toIso8601String();

    return firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .where('status', isEqualTo: 'Completed')
        // .where('bookingDateTime', isGreaterThanOrEqualTo: startDate)
        // .where('bookingDateTime', isLessThan: endDate)
        .orderBy('bookingDateTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(docSnapshot.data(), docSnapshot.id);
      }).toList();
    });
  }
}
