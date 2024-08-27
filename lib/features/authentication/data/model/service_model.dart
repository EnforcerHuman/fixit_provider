import 'package:fixit_provider/features/authentication/domain/enitities/service.dart';

class ServiceModel extends Service {
  ServiceModel(super.name, super.imageUrl);

  // Convert a ServiceModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  // Create a ServiceModel instance from a Map
  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      map['name'] as String,
      map['imageUrl'] as String,
    );
  }
}
