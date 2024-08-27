import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';

class ServiceProviderDataSource {
  Stream<Map<String, dynamic>> getSingleProviderDetails(String id) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection('ServiceProviders')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      Map<String, dynamic> providerDetails =
          snapshot.data() as Map<String, dynamic>;
      return providerDetails;
    });
  }

  void updateProviderDetails(String id, ServiceProvider servideProvider) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      firebaseFirestore
          .collection('ServiceProviders')
          .doc(id)
          .update(servideProvider.toJson());
    } catch (e) {
      //
    }
  }
}
