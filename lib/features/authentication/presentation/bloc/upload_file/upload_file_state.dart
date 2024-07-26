part of 'upload_file_bloc.dart';

sealed class UploadFileState {}

final class UploadFileInitial extends UploadFileState {}

final class FileUploaded extends UploadFileState {
  final String? imagepath;

  FileUploaded(this.imagepath);
}

final class FileUploading extends UploadFileState {}

final class FileUploadError extends UploadFileState {
  final String error;

  FileUploadError(this.error);
}

final class ProfileImageUploadedState extends UploadFileState {
  final String? imagepath;

  ProfileImageUploadedState(this.imagepath);
}

final class CertificateUploadedState extends UploadFileState {
  final String? imagepath;

  CertificateUploadedState(this.imagepath);
}

final class LicenseUploadedState extends UploadFileState {
  final String? imagepath;

  LicenseUploadedState(this.imagepath);
}

final class ProfileImageUploadErrorState extends UploadFileState {}

final class LicenseUploadErrorState extends UploadFileState {}

final class CertificateUploadErrorState extends UploadFileState {}

final class CertificateUploadingState extends UploadFileState {}

final class ProfileImageUploadingState extends UploadFileState {}

final class LicenseUploadingState extends UploadFileState {}
