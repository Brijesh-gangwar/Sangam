// import 'dart:convert';
// import 'package:app/Models/model_dept.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ApiServices {
//   Future<List<Departments>> getAllDepartments() async {
//     final url = "https://backend-code-4-nnid.onrender.com/api/getalldep";
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Departments.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch departments');
//     }
//   }
// }

// // Main App
// void main() {
//   runApp(MyApp());
// }

// // Main Widget
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Departments App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: DepartmentsScreen(),
//     );
//   }
// }

// // Stateful Screen
// class DepartmentsScreen extends StatefulWidget {
//   @override
//   _DepartmentsScreenState createState() => _DepartmentsScreenState();
// }

// class _DepartmentsScreenState extends State<DepartmentsScreen> {
//   List<Departments> departments = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDepartments(); // Fetch data when the screen loads
//   }

//   // Method to fetch data and update the state
//   Future<void> fetchDepartments() async {
//     try {
//       final apiService = ApiServices();
//       final List<Departments> fetchedDepartments =
//           await apiService.getAllDepartments();
//       setState(() {
//         departments = fetchedDepartments;
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Error: $error");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Departments'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator()) // Show loading spinner
//           : departments.isEmpty
//               ? Center(child: Text('No departments found')) // Show empty state
//               : ListView.builder(
//                   itemCount: departments.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           Text("id " + departments[index].id),
//                           Text("dept name " + departments[index].name),
//                           Text("description " + departments[index].description),
//                           Text("v" + departments[index].v.toString()),
//                         ],
//                       ),
//                     );
//                   }),
//     );
//   }
// }
