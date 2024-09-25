import 'dart:async';

import 'package:admin_portal/api_services/token_storage.dart';

import 'package:admin_portal/screens/auth/login_screen.dart';

import 'package:flutter/material.dart';

class splash_Screen extends StatefulWidget {
  const splash_Screen({super.key});

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  TokenStorage _tokenStorage = TokenStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        var token = _tokenStorage.getToken();

        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 40,
        width: 40,
        color: Colors.amber,
      ),
    );
  }
}
