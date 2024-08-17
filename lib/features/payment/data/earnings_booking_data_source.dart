import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/payment/domain/enitities/income.dart';

class EarningsBookingDataSource {
  final FirebaseFirestore firebaseFirestore;

  EarningsBookingDataSource(this.firebaseFirestore);

  // Stream<List<BookingModel>> getLast7CompletedBookings(String providerId) {
  //   return firebaseFirestore
  //       .collection('Bookings')
  //       .where('serviceProviderId', isEqualTo: providerId)
  //       .where('status', isEqualTo: 'Completed')
  //       .orderBy('bookingDateTime', descending: true)
  //       .limit(7)
  //       .snapshots()
  //       .map((querySnapshot) {
  //     return querySnapshot.docs.map((docSnapshot) {
  //       return BookingModel.fromMap(
  //           docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
  //     }).toList();
  //   });
  // }

  Stream<List<IncomeData>> getLast7CompletedBookings(String providerId) {
    return firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .where('status', isEqualTo: 'Completed')
        .orderBy('bookingDateTime', descending: true)
        .limit(7)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        final data = docSnapshot.data() as Map<String, dynamic>;

        // Parse the date string into a DateTime object
        final dateString = data['bookingDateTime'] as String?;
        final date = dateString != null
            ? DateTime.tryParse('$dateString T00:00:00') ??
                DateTime.now() // Add time to make it parseable
            : DateTime.now();

        // Parse the amount field into a double
        final amountString = data['amount'] as String?;
        final amount =
            amountString != null ? double.tryParse(amountString) ?? 0.0 : 0.0;

        // Create and return IncomeData
        return IncomeData(date: date, amount: amount);
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
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
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
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
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
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      }).toList();
    });
  }
}

class BookingRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<BookingModel>> getMonthlyBookings(
      String providerId, int month, int year) {
    String startDate = DateTime(year, month, 1).toIso8601String();
    String endDate = DateTime(year, month + 1, 1).toIso8601String();

    return _firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .where('status', isEqualTo: 'Completed')
        .where('bookingDateTime', isGreaterThanOrEqualTo: startDate)
        .where('bookingDateTime', isLessThan: endDate)
        .orderBy('bookingDateTime')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      }).toList();
    });
  }

  Stream<List<BookingModel>> getYearlyBookings(String providerId, int year) {
    String startDate = DateTime(year, 1, 1).toIso8601String();
    String endDate = DateTime(year + 1, 1, 1).toIso8601String();

    return _firebaseFirestore
        .collection('Bookings')
        .where('serviceProviderId', isEqualTo: providerId)
        .where('status', isEqualTo: 'Completed')
        .where('bookingDateTime', isGreaterThanOrEqualTo: startDate)
        .where('bookingDateTime', isLessThan: endDate)
        .orderBy('bookingDateTime')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      }).toList();
    });
  }
}
