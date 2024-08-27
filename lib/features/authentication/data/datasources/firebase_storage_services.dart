import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImageToFirebase(XFile image) async {
    try {
      final Reference storageReference =
          _storage.ref().child('images/${DateTime.now().toString()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(File(image.path));
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
