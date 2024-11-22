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

  Future<dynamic> getListTransactionByUserId(int id) async {
    return await get("transactions?user_id=$id");
  }

  Future<dynamic> createBookingRequest(dynamic body) async {
    return await post("booking-requests", body);
  }

  Future<dynamic> updateBookingRequest(dynamic body, int id) async {
  return await put("booking-requests/$id", body);
  }

  Future<dynamic> createContract(dynamic body) async {
    return await post("contracts/booking", body);
  }

  Future<dynamic> createContract2(dynamic body) async {
    return await post("contracts/booking", body);
  }

  Future<dynamic> updateContract(dynamic body, int id) async {
    return await put("contracts/$id", body);
  }

  Future<dynamic> getListSignaturesByUserId(int id) async {
    return await get("signatures?user_id=$id");
  }

  Future<dynamic> signPost(String path, dynamic body ) async {
    return await get("signatures?user_id=");
  }

  Future<dynamic> registerUser(dynamic body ) async {
    return await post("auth/register",body);
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
  // Future<dynamic> post(String url, dynamic body, {bool auth = true}) async {
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/$url'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(body),
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Server error!');
  //   }
  //
  //   return jsonDecode(response.body);
  // }

  Future<dynamic> post(String url, dynamic body, {bool auth = true}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$url'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // if (auth) 'Authorization': 'Bearer ${await getToken()}', // Thêm token nếu cần
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(_parseErrorMessage(response.body)
        );
      }
    } catch (e) {
      print('Error details: $e');
      rethrow;
    }
  }


  Future<String?> postSign(String url, String base64String, {bool auth = true}) async {
    final body = {
      "user_id": "083202010950_002",
      "serial_number": "54010101b710e8055dcb29e10f1aa584",
      "image_base64": "",
      "rectangles": [
        {
          "number_page_sign": 1,
          "margin_top": 100,
          "margin_left": 100,
          "margin_right": 500,
          "margin_bottom": 100
        }
      ],
      "visible_type": 0,
      "contact": "",
      "font_size": 12,
      "sign_files": [
        {
          "data_to_be_signed": "c803ba9e0b741be5995687c3611ecea617d532f12d7bae81aad0fa5d6ffe3f23",
          "doc_id": "32c-7401-25621",
          "file_type": "pdf",
          "sign_type": "hash",
          "file_base64": base64String
        }
      ]
    };


    try {
      final response = await http.post(
        Uri.parse('http://54.253.233.87:8010/$url'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // if (auth) 'Authorization': 'Bearer ${await getToken()}', // Thêm token nếu cần
        },
        body: jsonEncode(body),
      );

      print("Phản hồi:");
      print("body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);

        if (decodedResponse is List && decodedResponse.isNotEmpty) {
          final signedData = decodedResponse[0]['signedData'];
          return signedData != null ? signedData as String : null;
        } else {
          print("Phản hồi không chứa dữ liệu hợp lệ.");
          return null;
        }
      } else {
        throw Exception(_parseErrorMessage(response.body)
        );
      }
    } catch (e) {
      print('Error details: $e');
      rethrow;
    }
  }

  String _parseErrorMessage(String responseBody) {
    try {
      final parsed = jsonDecode(responseBody);
      return parsed['message'] ?? parsed['error'] ?? 'Unknown error occurred';
    } catch (e) {
      return responseBody;
    }
  }



  // Hàm PUT
  // Future<dynamic> put(String url, dynamic body, {bool auth = true}) async {
  //   final response = await http.put(
  //     Uri.parse('$_baseUrl/$url'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(body),
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Server error!');
  //   }
  //
  //   return jsonDecode(response.body);
  // }


  Future<dynamic> put(String url, dynamic body, {bool auth = true}) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$url'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // if (auth) 'Authorization': 'Bearer ${await getToken()}', // Thêm token nếu cần
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(_parseErrorMessage(response.body)
        );
      }
    } catch (e) {
      print('Error details: $e');
      rethrow;
    }
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
