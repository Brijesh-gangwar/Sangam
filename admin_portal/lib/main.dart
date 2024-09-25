import 'package:admin_portal/basic_layout.dart';


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Color dfcolor = Colors.blue;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BasicLayout(),
    );
  }
}
