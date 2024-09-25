import 'package:flutter/material.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var b = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: b * 0.82,
      height: h * 0.84,
      child: const Center(
        child: Text(
          "Coming soon",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
