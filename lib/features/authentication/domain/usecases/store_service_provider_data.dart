// lib/features/authentication/domain/usecases/store_service_provider_data.dart

import 'package:fixit_provider/features/authentication/data/datasources/service_provider_repository.dart';
import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';

class StoreServiceProviderData {
  final ServiceProviderRepository repository;

  StoreServiceProviderData(this.repository);

  Future<bool> call(ServiceProvider serviceProvider) async {
    try {
      await repository.storeServiceProviderData(serviceProvider);
      return true;
    } catch (e) {
      return false;
    }
  }
}
