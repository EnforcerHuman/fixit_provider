import 'package:fixit_provider/features/authentication/data/datasources/services_data_source.dart';

class ServiceTypeConverting {
  ServicesDataSource servicesDataSource = ServicesDataSource();
  Stream<List<String>> execute() async* {
    try {
      final result = await servicesDataSource.execute().first;
      List<String> processedData = [];
      for (var element in result) {
        processedData.add(element.name);
      }
      yield processedData;
    } catch (e) {
      yield [];
    }
  }
}
