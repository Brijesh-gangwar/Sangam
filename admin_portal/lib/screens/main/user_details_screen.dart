import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var b = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: b * 0.82,
      height: h * 0.84,
      child: const Center(
        child: Text("Coming soon"),
      ),
    );
  }
}
