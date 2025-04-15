import 'package:app/Screens/Main_Screens/Video_Calling.dart/join_video_call.dart';
import 'package:flutter/material.dart';

class SignVideo extends StatefulWidget {
  const SignVideo({super.key});

  @override
  State<SignVideo> createState() => _SignVideoState();
}

class _SignVideoState extends State<SignVideo> {
  TextEditingController callid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: callid,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JoinVideoCall(
                            callid: callid.text,
                          )),
                );
              },
              child: const Text('join video call'),
            ),
          ],
        ),
      ),
    );
  }
}
