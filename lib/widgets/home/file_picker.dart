import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:typed_data';

class SingleFilepickerScreen extends StatefulWidget {
  const SingleFilepickerScreen({super.key});

  @override
  State<SingleFilepickerScreen> createState() => _SingleFilepickerScreenState();
}

class _SingleFilepickerScreenState extends State<SingleFilepickerScreen> {
  // Variable to hold file name
  String? _fileName;
  Uint8List? _fileBytes; // Use for web to hold file content bytes
  io.File? _file; // Use for mobile to hold File object

  Future<void> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (kIsWeb) {
        // If running on web, use bytes
        _fileBytes = result.files.first.bytes;
        _fileName = result.files.first.name;
      } else {
        // If running on mobile (iOS/Android), use path
        final file = io.File(result.files.single.path!);
        _file = file;
        _fileName = file.path.split('/').last;
      }
      setState(() {});
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a file'),
      ));
    }
  }

  void _showPdfDialog(io.File pdfFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: PDFView(
              filePath: pdfFile.path,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _fileName != null ? "File Name: " : "No file selected",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          if (_fileName != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _fileName!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),

          // Nút để mở PDF trong dialog
          if (_file != null && _file!.path.endsWith('.pdf'))
            ElevatedButton(
              onPressed: () {
                _showPdfDialog(_file!);
              },
              child: const Text("View PDF"),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getFile();
        },
        label: const Text("Select File"),
      ),
    );
  }
}
