import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/authentication/data/model/service_model.dart';

class ServicesDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ServiceModel>> execute() {
    return firebaseFirestore.collection('Services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // ignore: unnecessary_cast
        final data = doc.data() as Map<String, dynamic>;
        return ServiceModel.fromMap(data);
      }).toList();
    });
  }
}
