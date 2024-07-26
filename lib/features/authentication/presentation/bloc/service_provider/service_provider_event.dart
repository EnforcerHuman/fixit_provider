import 'dart:io';

import 'package:fixit_provider/features/authentication/data/model/location.dart';
import 'package:fixit_provider/features/authentication/domain/usecases/store_service_provider_data.dart';

abstract class ServiceProviderEvent {}

class UpdateName extends ServiceProviderEvent {
  final String name;

  UpdateName(this.name);
}

class UpdateEmail extends ServiceProviderEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdatePhoneNumber extends ServiceProviderEvent {
  final String phoneNumber;

  UpdatePhoneNumber(this.phoneNumber);
}

class UpdateUserId extends ServiceProviderEvent {
  final String id;

  UpdateUserId(this.id);
}

class UpdateLocation extends ServiceProviderEvent {
  final Location location;

  UpdateLocation(this.location);
}

class UpdateBusinessName extends ServiceProviderEvent {
  final String businessName;

  UpdateBusinessName(this.businessName);
}

class UpdateBusinessAdress extends ServiceProviderEvent {
  final String businessAdress;

  UpdateBusinessAdress(this.businessAdress);
}

class UpdateExperience extends ServiceProviderEvent {
  final String experience;

  UpdateExperience(this.experience);
}

class UpdateServiceType extends ServiceProviderEvent {
  final String serviceType;

  UpdateServiceType(this.serviceType);
}

class UpdateArea extends ServiceProviderEvent {
  final String serviceArea;

  UpdateArea(this.serviceArea);
}

class UpdateWorkingFrom extends ServiceProviderEvent {
  final String workingFrom;

  UpdateWorkingFrom(this.workingFrom);
}

class UpdateWorkingUntil extends ServiceProviderEvent {
  final String workingUntil;

  UpdateWorkingUntil(this.workingUntil);
}

class UpdateSkills extends ServiceProviderEvent {}

class UpdateLicense extends ServiceProviderEvent {
  final String license;

  UpdateLicense(this.license);
}

class UpdateCertificate extends ServiceProviderEvent {
  final String certificate;

  UpdateCertificate(this.certificate);
}

class UpdatePhoto extends ServiceProviderEvent {
  final String profilePhoto;

  UpdatePhoto(this.profilePhoto);
}

class UpdateHourlyPayment extends ServiceProviderEvent {
  final String hourlyPay;

  UpdateHourlyPayment(this.hourlyPay);
}

class UpdateMoreInfo extends ServiceProviderEvent {
  final String moreInfo;

  UpdateMoreInfo(this.moreInfo);
}

class UpdateIsVerified extends ServiceProviderEvent {
  final bool isverified;

  UpdateIsVerified(this.isverified);
}

class SubmitServiceProvider extends ServiceProviderEvent {
  SubmitServiceProvider();
}

class UpdateRating extends ServiceProviderEvent {}

class UpdateRegistrationDate extends ServiceProviderEvent {}
// Add more events for other properties as needed (serviceTypes, rating, profileImageUrl, etc.)
