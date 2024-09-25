import 'dart:convert';

import 'package:admin_portal/models/project_model.dart';

import 'package:http/http.dart' as http;

Future<List<Project>?>? getprojects() async {
  final String getprojecturl =
      "https://backend-code-4-nnid.onrender.com/api/getProject";
  final response = await http.get(
    Uri.parse(getprojecturl),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    // Handle the error accordingly
    print('Failed to fetch user data');
    return null;
  }
}
