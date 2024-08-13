// import 'package:fixit_provider/features/booking/data/model/adress_model.dart';

// class BookingModel {
//   final String id;
//   final String serviceProviderId;
//   final String serviceProviderName;
//   final String userId;
//   final String userName;
//   final String userContact;
//   final String serviceId;
//   final String serviceName;
//   final String bookingDateTime;
//   final String createdAt;
//   final String status;
//   final String workDetails;
//   final String imageLink;
//   final String paymentStatus;
//   final String paymentMethod;
//   final String? cancellationReason;
//   final DateTime? cancellationDate;
//   final String providerContact;
//   final String serviceLocation;
//   final String? timeSlot;
//   final String? notes;
//   final DateTime statusUpdatedAt;
//   final String? expectedArrivalTime;
//   final AddressModel address;

//   BookingModel({
//     required this.id,
//     required this.serviceProviderId,
//     required this.serviceProviderName,
//     required this.userId,
//     required this.userName,
//     required this.userContact,
//     required this.serviceId,
//     required this.serviceName,
//     required this.bookingDateTime,
//     required this.createdAt,
//     required this.status,
//     required this.workDetails,
//     required this.imageLink,
//     required this.paymentStatus,
//     required this.paymentMethod,
//     this.cancellationReason,
//     this.cancellationDate,
//     required this.providerContact,
//     required this.serviceLocation,
//     this.timeSlot,
//     this.notes,
//     required this.statusUpdatedAt,
//     this.expectedArrivalTime,
//     required this.address,
//   });

//   factory BookingModel.fromMap(Map<String, dynamic> data, String documentId) {
//     return BookingModel(
//       id: documentId,
//       serviceProviderId: data['serviceProviderId'] as String,
//       serviceProviderName: data['serviceProviderName'] as String,
//       userId: data['userId'] as String,
//       userName: data['userName'] as String,
//       userContact: data['userContact'] as String,
//       serviceId: data['serviceId'] as String,
//       serviceName: data['serviceName'] as String,
//       bookingDateTime: data['bookingDateTime'] as String,
//       createdAt: data['createdAt'] as String,
//       status: data['status'] as String,
//       workDetails: data['workDetails'] as String,
//       imageLink: data['imageLink'] as String,
//       paymentStatus: data['paymentStatus'] as String,
//       paymentMethod: data['paymentMethod'] as String,
//       cancellationReason: data['cancellationReason'] as String?,
//       cancellationDate: data['cancellationDate'] != null
//           ? DateTime.parse(data['cancellationDate'] as String)
//           : null,
//       providerContact: data['providerContact'] as String,
//       serviceLocation: data['serviceLocation'] as String,
//       timeSlot: data['timeSlot'] as String?,
//       notes: data['notes'] as String?,
//       statusUpdatedAt: DateTime.parse(data['statusUpdatedAt'] as String),
//       expectedArrivalTime: data['expectedArrivalTime'] as String?,
//       address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'serviceProviderId': serviceProviderId,
//       'serviceProviderName': serviceProviderName,
//       'userId': userId,
//       'userName': userName,
//       'userContact': userContact,
//       'serviceId': serviceId,
//       'serviceName': serviceName,
//       'bookingDateTime': bookingDateTime,
//       'createdAt': createdAt,
//       'status': status,
//       'workDetails': workDetails,
//       'imageLink': imageLink,
//       'paymentStatus': paymentStatus,
//       'paymentMethod': paymentMethod,
//       'cancellationReason': cancellationReason,
//       'cancellationDate': cancellationDate?.toIso8601String(),
//       'providerContact': providerContact,
//       'serviceLocation': serviceLocation,
//       'timeSlot': timeSlot,
//       'notes': notes,
//       'statusUpdatedAt': statusUpdatedAt.toIso8601String(),
//       'expectedArrivalTime': expectedArrivalTime,
//       'address': address.toMap(),
//     };
//   }

//   BookingModel copyWith({
//     String? id,
//     String? serviceProviderId,
//     String? serviceProviderName,
//     String? userId,
//     String? userName,
//     String? userContact,
//     String? serviceId,
//     String? serviceName,
//     String? bookingDateTime,
//     String? createdAt,
//     String? status,
//     String? workDetails,
//     String? imageLink,
//     String? paymentStatus,
//     String? paymentMethod,
//     String? cancellationReason,
//     DateTime? cancellationDate,
//     String? providerContact,
//     String? serviceLocation,
//     String? timeSlot,
//     String? notes,
//     DateTime? statusUpdatedAt,
//     String? expectedArrivalTime,
//     AddressModel? address,
//   }) {
//     return BookingModel(
//       id: id ?? this.id,
//       serviceProviderId: serviceProviderId ?? this.serviceProviderId,
//       serviceProviderName: serviceProviderName ?? this.serviceProviderName,
//       userId: userId ?? this.userId,
//       userName: userName ?? this.userName,
//       userContact: userContact ?? this.userContact,
//       serviceId: serviceId ?? this.serviceId,
//       serviceName: serviceName ?? this.serviceName,
//       bookingDateTime: bookingDateTime ?? this.bookingDateTime,
//       createdAt: createdAt ?? this.createdAt,
//       status: status ?? this.status,
//       workDetails: workDetails ?? this.workDetails,
//       imageLink: imageLink ?? this.imageLink,
//       paymentStatus: paymentStatus ?? this.paymentStatus,
//       paymentMethod: paymentMethod ?? this.paymentMethod,
//       cancellationReason: cancellationReason ?? this.cancellationReason,
//       cancellationDate: cancellationDate ?? this.cancellationDate,
//       providerContact: providerContact ?? this.providerContact,
//       serviceLocation: serviceLocation ?? this.serviceLocation,
//       timeSlot: timeSlot ?? this.timeSlot,
//       notes: notes ?? this.notes,
//       statusUpdatedAt: statusUpdatedAt ?? this.statusUpdatedAt,
//       expectedArrivalTime: expectedArrivalTime ?? this.expectedArrivalTime,
//       address: address ?? this.address,
//     );
//   }
// }

// import 'package:fixit/features/bookings/data/model/adress_model.dart';

import 'package:fixit_provider/features/booking/data/model/adress_model.dart';

class BookingModel {
  final String id;
  final String serviceProviderId;
  final String serviceProviderName;
  final String userId;
  final String userName;
  final String userContact;
  final String serviceId;
  final String serviceName;
  final String bookingDateTime;
  final String createdAt;
  final String status;
  final String workDetails;
  final String imageLink;
  final String paymentStatus;
  final String paymentMethod;
  final String? cancellationReason;
  final DateTime? cancellationDate;
  final String providerContact;
  final String serviceLocation;
  final String? timeSlot;
  final String? notes;
  final DateTime statusUpdatedAt;
  final String? expectedArrivalTime;
  final AddressModel address;
  final String hourlyPayment;
  final String totalPayment;
  final List<String> orders; // New field

  BookingModel({
    required this.id,
    required this.serviceProviderId,
    required this.serviceProviderName,
    required this.userId,
    required this.userName,
    required this.userContact,
    required this.serviceId,
    required this.serviceName,
    required this.bookingDateTime,
    required this.createdAt,
    required this.status,
    required this.workDetails,
    required this.imageLink,
    required this.paymentStatus,
    required this.paymentMethod,
    this.cancellationReason,
    this.cancellationDate,
    required this.providerContact,
    required this.serviceLocation,
    this.timeSlot,
    this.notes,
    required this.statusUpdatedAt,
    this.expectedArrivalTime,
    required this.address,
    required this.hourlyPayment,
    required this.totalPayment,
    required this.orders, // Initialize new field
  });

  factory BookingModel.fromMap(Map<String, dynamic> data, String documentId) {
    return BookingModel(
      id: documentId,
      serviceProviderId: data['serviceProviderId'] as String,
      serviceProviderName: data['serviceProviderName'] as String,
      userId: data['userId'] as String,
      userName: data['userName'] as String,
      userContact: data['userContact'] as String,
      serviceId: data['serviceId'] as String,
      serviceName: data['serviceName'] as String,
      bookingDateTime: data['bookingDateTime'] as String,
      createdAt: data['createdAt'] as String,
      status: data['status'] as String,
      workDetails: data['workDetails'] as String,
      imageLink: data['imageLink'] as String,
      paymentStatus: data['paymentStatus'] as String,
      paymentMethod: data['paymentMethod'] as String,
      cancellationReason: data['cancellationReason'] as String?,
      cancellationDate: data['cancellationDate'] != null
          ? DateTime.parse(data['cancellationDate'] as String)
          : null,
      providerContact: data['providerContact'] as String,
      serviceLocation: data['serviceLocation'] as String,
      timeSlot: data['timeSlot'] as String?,
      notes: data['notes'] as String?,
      statusUpdatedAt: DateTime.parse(data['statusUpdatedAt'] as String),
      expectedArrivalTime: data['expectedArrivalTime'] as String?,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      hourlyPayment: data['hourlyPayment'] as String,
      totalPayment: data['totalPayment'] as String,
      orders:
          List<String>.from(data['orders'] as List<dynamic>), // Map new field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceProviderId': serviceProviderId,
      'serviceProviderName': serviceProviderName,
      'userId': userId,
      'userName': userName,
      'userContact': userContact,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'bookingDateTime': bookingDateTime,
      'createdAt': createdAt,
      'status': status,
      'workDetails': workDetails,
      'imageLink': imageLink,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'cancellationReason': cancellationReason,
      'cancellationDate': cancellationDate?.toIso8601String(),
      'providerContact': providerContact,
      'serviceLocation': serviceLocation,
      'timeSlot': timeSlot,
      'notes': notes,
      'statusUpdatedAt': statusUpdatedAt.toIso8601String(),
      'expectedArrivalTime': expectedArrivalTime,
      'address': address.toMap(),
      'hourlyPayment': hourlyPayment,
      'totalPayment': totalPayment,
      'orders': orders, // Add new field
    };
  }

  BookingModel copyWith({
    String? id,
    String? serviceProviderId,
    String? serviceProviderName,
    String? userId,
    String? userName,
    String? userContact,
    String? serviceId,
    String? serviceName,
    String? bookingDateTime,
    String? createdAt,
    String? status,
    String? workDetails,
    String? imageLink,
    String? paymentStatus,
    String? paymentMethod,
    String? cancellationReason,
    DateTime? cancellationDate,
    String? providerContact,
    String? serviceLocation,
    String? timeSlot,
    String? notes,
    DateTime? statusUpdatedAt,
    String? expectedArrivalTime,
    AddressModel? address,
    String? hourlyPayment,
    String? totalPayment,
    List<String>? orders, // Add new field
  }) {
    return BookingModel(
      id: id ?? this.id,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      serviceProviderName: serviceProviderName ?? this.serviceProviderName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userContact: userContact ?? this.userContact,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      bookingDateTime: bookingDateTime ?? this.bookingDateTime,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      workDetails: workDetails ?? this.workDetails,
      imageLink: imageLink ?? this.imageLink,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      cancellationDate: cancellationDate ?? this.cancellationDate,
      providerContact: providerContact ?? this.providerContact,
      serviceLocation: serviceLocation ?? this.serviceLocation,
      timeSlot: timeSlot ?? this.timeSlot,
      notes: notes ?? this.notes,
      statusUpdatedAt: statusUpdatedAt ?? this.statusUpdatedAt,
      expectedArrivalTime: expectedArrivalTime ?? this.expectedArrivalTime,
      address: address ?? this.address,
      hourlyPayment: hourlyPayment ?? this.hourlyPayment,
      totalPayment: totalPayment ?? this.totalPayment,
      orders: orders ?? this.orders, // Assign new field
    );
  }
}
