import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<dynamic> uploadFile(Uint8List bytes, String filename) async {
    var request = http.MultipartRequest(
        'Post', Uri.parse('https://api.escuelajs.co/api/v1/files/upload'));

    var multipartfile = http.MultipartFile(
      'file',
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: filename,
    );

    request.files.add(multipartfile);

    final response = await request.send();

    if (response.statusCode == 201) {
      var data = await response.stream.bytesToString();
      return jsonDecode(data);
    }
  }
}
