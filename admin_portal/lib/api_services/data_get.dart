// import 'dart:convert';

// import 'package:flutter_practice/list/list_wheel_scrollview.dart';

// import 'mulitple_post_model.dart';
// import 'singlepostwithmodel.dart';
// import 'package:http/http.dart' as http;

// class apiservices {
//   // with model
//   Future<singlepostwithmodel?> getsinglepostwithmodel() async {
//     try {
//       var response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

//       if (response.statusCode == 200) {
//         singlepostwithmodel modelsingle =
//             singlepostwithmodel.fromJson(jsonDecode(response.body));

//         return modelsingle;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   //without model
//   Future<dynamic> getsinglepostwithoutmodel() async {
//     try {
//       var response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

//       if (response.statusCode == 200) {
//         final body = response.body;
//         final data = jsonDecode(body);
//         return data;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   // multiple posts with model

//   Future<List<mulitple_post_model>?> getmultiple_post_withmodel() async {
//     try {
//       var response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

//       if (response.statusCode == 200) {
//         List<mulitple_post_model> multiple_post_model_instance =
//             List<mulitple_post_model>.from(jsonDecode(response.body)
//                 .map((x) => mulitple_post_model.fromJson(x)));

//         return multiple_post_model_instance;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   //mulitple posts without model

//   Future<dynamic> getmulitplewithoutmodel() async {
//     try {
//       var response = await http
//           .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

//       if (response.statusCode == 200) {
        
//         var data_model = jsonDecode(response.body);
//         return data_model;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }
// }
