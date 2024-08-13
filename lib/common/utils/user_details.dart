import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';

class UserDetails {
  Future<String> getUserId() async {
    String userId = await SharedPreferencesHelper.getUserId();
    return userId;
  }
}
