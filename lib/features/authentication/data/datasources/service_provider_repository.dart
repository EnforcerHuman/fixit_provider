// lib/features/authentication/data/repositories/service_provider_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';

class ServiceProviderRepository {
  final FirebaseFirestore _firestore;

  ServiceProviderRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> storeServiceProviderData(ServiceProvider serviceProvider) async {
    final collectionRef = _firestore.collection('ServiceProviders');

    if (serviceProvider.id.isEmpty) {
      throw Exception('Service Provider ID is empty despite expectation');
    }

    try {
      await collectionRef.doc(serviceProvider.id).set(serviceProvider.toJson());
      print('ServiceProvider data stored successfully!');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<bool> isServiceProviderVerifed(String userId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final user = await firebaseFirestore
        .collection('ServiceProviders')
        .doc(userId)
        .get();
    print('user is verified or not : *******************');
    print(user['isVerified']);
    return user['isVerified'];
  }
}
