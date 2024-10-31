import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/user.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _accessToken;
  User? _user;

  String? get accessToken => _accessToken;
  User? get userInfo => _user;

  Future<void> login(String phone, String password) async {
    try {
      final response = await _apiService.login(phone, password);

      if (response['status'] == 'SUCCESS') {
        _accessToken = response['data']['access_token'];
        _user = User.fromJson(response['data']['user_info']);
        await _saveToLocal();
        notifyListeners();
      } else {
        throw Exception(response['message'] ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> _saveToLocal() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('access_token', _accessToken!);
    // await prefs.setString('user_info', json.encode(_user));
    print('Save to local');
    print("Access token: $_accessToken");
    print("User info: $_user");
    // html.window.localStorage['access_token'] = _accessToken!;
    // html.window.localStorage['user_info'] = _user.toString();
  }

  Future<void> logout() async {
    _accessToken = null;
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
