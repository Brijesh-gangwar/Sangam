import 'dart:async';

import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  StreamController<String> streamController = StreamController<String>();
  late Stream<String> datastream;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    datastream = streamController.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<String>(
                stream: datastream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                    );
                  }
                  return Text("No data");
                }),
            StreamBuilder<String>(
                stream: datastream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                    );
                  }
                  return const Text("No data");
                }),
            const  SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: textEditingController,
              ),
            ),
          const    SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                streamController.add(textEditingController.text);
              },
              child:  const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
