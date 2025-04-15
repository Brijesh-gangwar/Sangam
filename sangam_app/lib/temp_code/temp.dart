import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sangam_app/api_services/services.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    String uploadedimage = "";

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uploadedimage == ""
              ?const SizedBox(
                  height: 200,
                  width: 200,
                )
              : Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: NetworkImage(uploadedimage))),
                ),
          Center(
            child: ElevatedButton(
              child: Text("upload image"),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  Uint8List bytes = await image.readAsBytes();

                  ApiServices().uploadFile(bytes, image.name).then((value) {
                    print(value['location'].toString());
                    setState(() {
                      uploadedimage = value['location'].toString();
                    });
                  }).onError(
                    (error, stackTrace) {
                      print(error.toString());
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
