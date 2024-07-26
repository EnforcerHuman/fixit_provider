import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/firebase_storage_services.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_file_event.dart';
part 'upload_file_state.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final FirebaseStorageService firebaseStorage;

  UploadFileBloc(this.firebaseStorage) : super(UploadFileInitial()) {
    on<ImageUpload>((event, emit) async {
      emit(FileUploading());
      try {
        String? imagePath =
            await firebaseStorage.uploadImageToFirebase(event.certificate);
        if (imagePath != null) {
          emit(FileUploaded(imagePath));
        } else {
          emit(FileUploadError('Image upload failed'));
        }
      } catch (e) {
        emit(FileUploadError(e.toString()));
      }
    });

    on<LicenseUploadEvent>((event, emit) async {
      emit(LicenseUploadingState());
      try {
        String? imagePath =
            await firebaseStorage.uploadImageToFirebase(event.license);
        if (imagePath != null) {
          print('Image Path I $imagePath');
          print('****************************');
          emit(LicenseUploadedState(imagePath));
        } else {
          emit(LicenseUploadErrorState());
        }
      } catch (e) {
        emit(FileUploadError(e.toString()));
      }
    });

    on<CertificateUploadEvent>((event, emit) async {
      emit(CertificateUploadingState());
      try {
        String? imagePath =
            await firebaseStorage.uploadImageToFirebase(event.certificate);
        if (imagePath != null) {
          emit(CertificateUploadedState(imagePath));
        } else {
          emit(CertificateUploadErrorState());
        }
      } catch (e) {
        emit(FileUploadError(e.toString()));
      }
    });

    on<ProfileImageUploadEvent>((event, emit) async {
      emit(ProfileImageUploadingState());
      try {
        String? imagePath =
            await firebaseStorage.uploadImageToFirebase(event.image);
        if (imagePath != null) {
          emit(ProfileImageUploadedState(imagePath));
        } else {
          emit(ProfileImageUploadErrorState());
        }
      } catch (e) {
        emit(FileUploadError(e.toString()));
      }
    });
  }
}
