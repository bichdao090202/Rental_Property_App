import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://your-api-url.com';

  // Hàm GET
  Future<dynamic> get(String url, {bool auth = true, String cache = 'default'}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
        // Thêm các headers khác như authorization nếu cần
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Server error!');
    }

    return jsonDecode(response.body);
  }

  // Hàm POST
  Future<dynamic> post(String url, dynamic body, {bool auth = true}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Server error!');
    }

    return jsonDecode(response.body);
  }

  // Hàm PUT
  Future<dynamic> put(String url, dynamic body, {bool auth = true}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Server error!');
    }

    return jsonDecode(response.body);
  }

  // Hàm DELETE
  Future<dynamic> delete(String url, {bool auth = true}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$url'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Server error!');
    }

    return jsonDecode(response.body);
  }
}
