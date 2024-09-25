import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://backend-code-5-2tsr.onrender.com/admin/login';
  final String userUrl = 'https://dummyjson.com/auth/me';

  Future<String?> login(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print("---------------------------------------------------");
      print(responseData);
      return responseData['token'];
    } else {
      // Handle the error accordingly
      print('Failed to login');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String token) async {
    final response = await http.get(
      Uri.parse(userUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Handle the error accordingly
      print('Failed to fetch user data');
      return null;
    }
  }
}
