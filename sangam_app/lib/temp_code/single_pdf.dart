import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:sangam_app/temp_code/pdf.dart';

class SinglePdf extends StatefulWidget {
  const SinglePdf({super.key});

  @override
  State<SinglePdf> createState() => _SinglePdfState();
}

class _SinglePdfState extends State<SinglePdf> {
  List<File> uploadedFiles = [];
  List<PdfController> pdfControllers = [];
  List<Image> images = [];

  /// Picks a single file from the device (PDF or image).
  Future<File?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  /// Uploads a single file to the specified API.
  Future<void> uploadSingleFile(File file) async {
    final uri = Uri.parse("https://api.escuelajs.co/api/v1/files/upload");

    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: file.path.endsWith('.pdf')
          ? MediaType('application', 'pdf')
          : MediaType('image', 'jpeg'),
    ));

    var response = await request.send();

    if (response.statusCode == 201) {
      print('File uploaded successfully!');
      print('File uploaded successfully! : ${response.statusCode}');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadAndDisplayPage(),
          ));
    } else {
      print('Failed to upload file. Status code: ${response.statusCode}');
    }
  }

  /// Handles selecting, displaying a single file (PDF or image).
  Future<void> selectAndDisplaySingleFile() async {
    File? file = await pickSingleFile();
    if (file != null) {
      setState(() {
        uploadedFiles = [file]; // Store only the single selected file
      });

      pdfControllers.clear();
      images.clear();

      // Load the file: PDF for PdfController, image for Image widget.
      if (file.path.endsWith('.pdf')) {
        Uint8List bytes = await file.readAsBytes();
        Future<PdfDocument> document = PdfDocument.openData(bytes);
        pdfControllers.add(PdfController(document: document));
      } else if (file.path.endsWith('.jpg') ||
          file.path.endsWith('.jpeg') ||
          file.path.endsWith('.png')) {
        images.add(Image.file(file));
      }
      setState(() {});
    } else {
      print('No file selected.');
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
      appBar: AppBar(title: Text('Upload and Display File')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: selectAndDisplaySingleFile,
            child: Text('Select and Display File'),
          ),
          ElevatedButton(
            onPressed: uploadedFiles.isNotEmpty
                ? () => uploadSingleFile(uploadedFiles[0])
                : null,
            child: Text('Upload'),
          ),
          Expanded(
            child: uploadedFiles.isEmpty
                ? Center(child: Text('No file to display'))
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

  ImageViewPage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Image')),
      body: Center(
        child: Container(
          height: 300, // Adjusted for a clearer view
          width: 300,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Text(
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
