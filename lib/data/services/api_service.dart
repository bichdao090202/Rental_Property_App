import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://54.253.233.87:3006/api/v1';

  Future<dynamic> login(String phone, String password) async {
    final body = {
      "phone": phone,
      "password": password,
    };
    return await post("auth/login", body);
  }

  Future<dynamic> getListRoom() async {
    return await get("rooms?page_id=1&per_page=-1");
  }

  Future<dynamic> getUserById(int id) async {
    return await get("users/$id");
  }

  Future<dynamic> getRoomById(int id) async {
    return await get("rooms/$id");
  }

  Future<dynamic> getBookingRequestByRenterId(int id) async {
    print(id);
    return await get("booking-requests?renter_id=$id");
  }

  Future<dynamic> getBookingRequestByLessorId(int id) async {
    return await get("booking-requests?lessor_id=$id");
  }

  Future<dynamic> getContractByRenterId(int id) async {
    return await get("contracts?renter_id=$id");
  }

  Future<dynamic> getContractByLessorId(int id) async {
    return await get("contracts?lessor_id=$id");
  }

  Future<dynamic> get(String url, {bool auth = true, String cache = 'default'}) async {
    final response = await http.get(
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
