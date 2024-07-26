part of 'upload_file_bloc.dart';

sealed class UploadFileEvent {}

class ImageUpload extends UploadFileEvent {
  final XFile certificate;

  ImageUpload(this.certificate);
}

class LicenseUploadEvent extends UploadFileEvent {
  final XFile license;

  LicenseUploadEvent(this.license);
}

class CertificateUploadEvent extends UploadFileEvent {
  final XFile certificate;

  CertificateUploadEvent(this.certificate);
}

class ProfileImageUploadEvent extends UploadFileEvent {
  final XFile image;

  ProfileImageUploadEvent(this.image);
}
