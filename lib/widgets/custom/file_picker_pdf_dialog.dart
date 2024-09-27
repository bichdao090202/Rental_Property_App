// // void showFilePickerDialogg(BuildContext context) {
// //   final TextEditingController contractNameController = TextEditingController();
// //             child: TextField(
// //               controller: contractNameController,
// //               decoration: const InputDecoration(hintText: 'Nhập tên hợp đồng'),
// //             ),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               final String contractName = contractNameController.text;
// //               if (contractName.isNotEmpty) {
// //                 String? fileContent; // Add logic to read the file content as a string
// //                 Contract newContract = Contract(
// //                   id: 4,
// //                   landlordId: 2,
// //                   name: contractName,
// //                   content: fileContent ?? 'Nội dung hợp đồng không có',
// //                   pdfPath: 'assets/hop-dong-thue-nha-o_2810144434_2011152916_0804150405.pdf',
// //                 addContract(newContract);
// //                 Navigator.of(context).pop();
// //               } else {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text('Vui lòng nhập tên hợp đồng')),
// //                 );
// //               }
// //             },
// //             child: const Text('Tích hợp chữ ký số'),
// //           ),

import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rental_property_app/common/api.dart';
import 'package:rental_property_app/common/file-base64.dart';
import 'package:rental_property_app/widgets/custom/pdf_viewer_dialog.dart';

class FilePickerDialog extends StatefulWidget {
  const FilePickerDialog({Key? key}) : super(key: key);

  @override
  State<FilePickerDialog> createState() => _FilePickerDialogState();

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(16),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Upload Contract',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: FilePickerDialog()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilePickerDialogState extends State<FilePickerDialog> {
  String? _fileName;
  io.File? _file;
  String? filePath;
  final TextEditingController _contractNameController = TextEditingController();

  Future<void> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (kIsWeb) {
        _fileName = result.files.first.name;
      } else {
        final file = io.File(result.files.single.path!);
        filePath = result.files.single.path;
        _file = file;
        _fileName = file.path.split('/').last;
      }
      setState(() {});
    }
  }

  void _showPdfDialog(io.File pdfFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PdfViewerDialog(pdfFile: pdfFile);
      },
    );
  }

  Future<void> _handleAddDigitalSignature() async {
    try {
      final response = await signPdfDocument(stringBase64);
      if (response.signedFileBase64.isEmpty) {
        throw Exception('No data received from server');
      }
      try {
        Uint8List fileBytes = base64Decode(response.signedFileBase64);

        // final directory = await getTemporaryDirectory();
        final directory = await getApplicationSupportDirectory();
        final filePath = '${directory.path}/signed_document.pdf';
        final pdfFile = io.File(filePath);
        await pdfFile.writeAsBytes(fileBytes);
        _showPdfDialog(pdfFile);
      } catch (e){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Lỗi'),
              content: const Text('Lỗi mở file'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Đóng'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Lỗi server, thử lại sau.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _contractNameController,
            decoration: InputDecoration(
              labelText: 'Contract Name',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _fileName != null ? Icons.insert_drive_file : Icons.upload_file,
                    size: 48,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _fileName ?? "No file selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _fileName != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: getFile,
            icon: const Icon(Icons.file_upload),
            label: const Text("Select File"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          if (_file != null && _file!.path.toLowerCase().endsWith('.pdf'))
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: () => _showPdfDialog(_file!),
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("View PDF"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                // onPressed: _file != null ? _handleAddDigitalSignature : null,
                onPressed: _handleAddDigitalSignature,
                child: const Text('Add Digital Signature'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}