import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/authentication/data/datasources/service_provider_repository.dart';
import 'package:fixit_provider/features/profile/data/service_provider_data_source.dart';

class GetProviderDetails {
  final ServiceProviderRepository repository;

  GetProviderDetails(this.repository);

  Stream<Map<String, dynamic>> execute() async* {
    String id = await SharedPreferencesHelper.getUserId();
    ServiceProviderDataSource serviceProviderDataSource =
        ServiceProviderDataSource();
    yield* serviceProviderDataSource.getSingleProviderDetails(id);
  }
}
