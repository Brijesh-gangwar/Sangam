// import 'package:admin_portal/api_services/api_service.dart';
// import 'package:admin_portal/api_services/token_storage.dart';
// import 'package:admin_portal/screens/dashboard_screen.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   final ApiService _apiService = ApiService();
//   final TokenStorage _tokenStorage = TokenStorage();

//   void _login(BuildContext context) async {
//     final username = _usernameController.text;
//     final password = _passwordController.text;
//     final email = _emailController.text;

//     final token = await _apiService.login(username, password);

//     if (token != null) {
//       await _tokenStorage.saveToken(token);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const DashboardScreen(),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Failed to login'),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _login(context),
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
