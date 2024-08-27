import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';

abstract class ServiceProviderRepository {
  Stream<ServiceProvider> getServiceProviderDetails(String id);
}
