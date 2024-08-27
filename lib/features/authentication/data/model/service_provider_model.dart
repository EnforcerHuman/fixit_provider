import 'package:fixit_provider/features/authentication/data/model/location.dart';

class ServiceProvider {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final Location location;
  final String serviceTypes;
  final double rating;
  final String profileImage;
  final String? certificate;
  final String? license;
  final String hourlyPay;
  final DateTime registrationDate;
  final bool isVerified;
  final String experience;
  final String workingFrom;
  final String workingTo;
  final String skills;
  final String businessAddress;
  final String info;
  final String serviceArea;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.location,
    required this.serviceTypes,
    required this.rating,
    required this.profileImage,
    this.certificate,
    this.license,
    required this.hourlyPay,
    required this.registrationDate,
    required this.isVerified,
    required this.experience,
    required this.workingFrom,
    required this.workingTo,
    required this.skills,
    required this.businessAddress,
    required this.info,
    required this.serviceArea,
  });

  ServiceProvider copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    Location? location,
    String? serviceTypes,
    double? rating,
    String? profileImage,
    String? certificate,
    String? license,
    String? hourlyPay,
    DateTime? registrationDate,
    bool? isVerified,
    String? experience,
    String? workingFrom,
    String? workingTo,
    String? skills,
    String? businessAddress,
    String? info,
    String? serviceArea,
  }) {
    return ServiceProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      serviceTypes: serviceTypes ?? this.serviceTypes,
      rating: rating ?? this.rating,
      profileImage: profileImage ?? this.profileImage,
      certificate: certificate ?? this.certificate,
      license: license ?? this.license,
      hourlyPay: hourlyPay ?? this.hourlyPay,
      registrationDate: registrationDate ?? this.registrationDate,
      isVerified: isVerified ?? this.isVerified,
      experience: experience ?? this.experience,
      workingFrom: workingFrom ?? this.workingFrom,
      workingTo: workingTo ?? this.workingTo,
      skills: skills ?? this.skills,
      businessAddress: businessAddress ?? this.businessAddress,
      info: info ?? this.info,
      serviceArea: serviceArea ?? this.serviceArea,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'location': location.toJson(),
      'serviceTypes': serviceTypes,
      'rating': rating,
      'profileImage': profileImage,
      'certificate': certificate,
      'license': license,
      'hourlyPay': hourlyPay,
      'registrationDate': registrationDate.toIso8601String(),
      'isVerified': isVerified,
      'experience': experience,
      'workingFrom': workingFrom,
      'workingTo': workingTo,
      'skills': skills,
      'businessAddress': businessAddress,
      'info': info,
      'serviceArea': serviceArea,
    };
  }

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      location: Location.fromJson(json['location']),
      serviceTypes: json['serviceTypes'],
      rating: (json['rating'] as num).toDouble(),
      profileImage: json['profileImage'],
      certificate: json['certificate'],
      license: json['license'],
      hourlyPay: json['hourlyPay'],
      registrationDate: DateTime.parse(json['registrationDate']),
      isVerified: json['isVerified'],
      experience: json['experience'],
      workingFrom: json['workingFrom'],
      workingTo: json['workingTo'],
      skills: json['skills'],
      businessAddress: json['businessAddress'],
      info: json['info'],
      serviceArea: json['serviceArea'],
    );
  }
}
