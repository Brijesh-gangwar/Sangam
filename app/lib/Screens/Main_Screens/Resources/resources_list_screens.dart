import 'package:flutter/material.dart';

class ResourcesListScreens extends StatefulWidget {
  const ResourcesListScreens({super.key});

  @override
  State<ResourcesListScreens> createState() => _ResourcesListScreensState();
}

class _ResourcesListScreensState extends State<ResourcesListScreens> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("resources list"),
    );
  }
}