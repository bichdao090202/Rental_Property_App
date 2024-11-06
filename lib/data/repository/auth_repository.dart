import 'package:rental_property_app/data/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  // Future<AuthResponse>? login(String phone, String password) {
  //   return _apiService.login(phone, password);
  // }
}
