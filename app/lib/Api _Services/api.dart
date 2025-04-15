import 'dart:convert';

import 'package:app/Models/model_dept.dart';
import 'package:http/http.dart' as http;


class ApiServices {

  //get all departments

  Future<List<Departments>> getAllDepartments() async {
    const url = "https://backend-code-4-nnid.onrender.com/api/getalldep";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Departments.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch departments');
    }
  }


  //
}