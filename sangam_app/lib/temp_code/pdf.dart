import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

class UploadAndDisplayPage extends StatefulWidget {
  @override
  _UploadAndDisplayPageState createState() => _UploadAndDisplayPageState();
}

class _UploadAndDisplayPageState extends State<UploadAndDisplayPage> {
  List<File> uploadedFiles = [];
  List<PdfController> pdfControllers = [];
  List<Image> images = [];

  /// Picks multiple files from the device (PDFs and images).
  Future<List<File>?> pickMultipleFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    }
    return null;
  }

  /// Uploads multiple files to the specified API.
  Future<void> uploadMultipleFiles(List<File> files) async {
    final uri = Uri.parse("https://api.escuelajs.co/api/v1/files/upload");

    var request = http.MultipartRequest('POST', uri);

    for (var file in files) {
      Uint8List bytes = await file.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes(
        'files',
        bytes,
        filename: file.path.split('/').last,
        contentType: file.path.endsWith('.pdf')
            ? MediaType('application', 'pdf')
            : MediaType('image', 'jpeg'),
      ));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Files uploaded successfully!');
    } else {
      print('Failed to upload files. Status code: ${response.statusCode}');
    }
  }

  /// Handles selecting, uploading, and loading files (PDFs and images).
  Future<void> selectUploadAndDisplayFiles() async {
    List<File>? files = await pickMultipleFiles();
    if (files != null) {
      setState(() {
        uploadedFiles = files;
      });

      // Upload the files
      await uploadMultipleFiles(files);

      pdfControllers.clear();
      images.clear();

      // Load each file: PDF for PdfController, image for Image widget.
      for (var file in files) {
        if (file.path.endsWith('.pdf')) {
          Uint8List bytes = await file.readAsBytes();
          Future<PdfDocument> document = PdfDocument.openData(bytes);
          pdfControllers.add(PdfController(document: document));
        } else if (file.path.endsWith('.jpg') ||
            file.path.endsWith('.jpeg') ||
            file.path.endsWith('.png')) {
          images.add(Image.file(file));
        }
      }
      setState(() {});
    } else {
      print('No files selected.');
    }
  }

  /// Opens a new screen to display PDF or image
  void openFileViewPage(int index) {
    File file = uploadedFiles[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => file.path.endsWith('.pdf')
            ? PdfViewPage(controller: pdfControllers[index])
            : ImageViewPage(imageFile: file), // Pass the File to ImageViewPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload and Display Files')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: selectUploadAndDisplayFiles,
            child: Text('Select, Upload, and Display Files'),
          ),
          ElevatedButton(
              onPressed: () {
                uploadMultipleFiles;
              },
              child: Text('Upload')),
          Expanded(
            child: uploadedFiles.isEmpty
                ? Center(child: Text('No files to display'))
                : ListView.builder(
                    itemCount: uploadedFiles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(uploadedFiles[index].path.endsWith('.pdf')
                            ? Icons.picture_as_pdf
                            : Icons.image),
                        title: Text(uploadedFiles[index].path.split('/').last),
                        onTap: () => openFileViewPage(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in pdfControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

// New page to view PDF
class PdfViewPage extends StatelessWidget {
  final PdfController controller;

  PdfViewPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View PDF')),
      body: PdfView(controller: controller),
    );
  }
}

// New page to view Image
class ImageViewPage extends StatelessWidget {
  final File imageFile;

  ImageViewPage({required this.imageFile}); // Receive the file path

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Image')),
      body: Center(
        child: Container(
          height: 300, // Adjusted for a clearer view
          width: 300,
          child: Image.file(
            imageFile, // Directly use the file
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Text(
                'Failed to load image',
                style: TextStyle(fontSize: 18),
              );
            },
          ),
        ),
      ),
    );
  }
}
