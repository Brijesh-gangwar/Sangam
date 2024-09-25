import 'package:flutter/material.dart';

class PortalSetupScreen extends StatefulWidget {
  const PortalSetupScreen({super.key});

  @override
  State<PortalSetupScreen> createState() => _PortalSetupScreenState();
}

class _PortalSetupScreenState extends State<PortalSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("portal setup screen"),
      ),
      body:const Column(
        children: [
          Text("enter portal setup key"),
        ],
      ),
    );
  }
}
