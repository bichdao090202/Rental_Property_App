import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:typed_data';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/models/contract.dart';


class FilePickerDialog extends StatefulWidget {
  const FilePickerDialog({super.key});

  @override
  State<FilePickerDialog> createState() => _FilePickerDialogState();
}

class _FilePickerDialogState extends State<FilePickerDialog> {
  String? _fileName;
  Uint8List? _fileBytes;
  io.File? _file;
  Future<void> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (kIsWeb) {
        _fileBytes = result.files.first.bytes;
        _fileName = result.files.first.name;
      } else {
        final file = io.File(result.files.single.path!);
        _file = file;
        _fileName = file.path.split('/').last;
      }
      setState(() {});
    } else {

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
            height: MediaQuery.of(context).size.height * 0.7,
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       _fileName != null ? "File Name: " : "No file selected",
          //       textAlign: TextAlign.center,
          //       style: const TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "File Name: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Text(
                  _fileName ?? "No file selected",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
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
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),


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

// void showFilePickerDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         content: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.9,
//           height: MediaQuery.of(context).size.height * 0.9,
//           child: const FilePickerDialog(),
//         ),
//         actions: [
//           // Nút "Add"
//           TextButton(
//             onPressed: () {
//               // Xử lý khi bấm nút "Add"
//               Navigator.of(context).pop();
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   const SnackBar(content: Text("Tích hợp chữ ký số")),
//               // );
//             },
//             child: const Text('Tích hợp chữ ký số'),
//           ),
//           // Nút "Close"
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Đóng dialog
//             },
//             child: const Text('Close'),
//           ),
//         ],
//       );
//     },
//   );
// }

void showFilePickerDialog(BuildContext context) {
  final TextEditingController contractNameController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: contractNameController,
              decoration: const InputDecoration(hintText: 'Nhập tên hợp đồng'),
            ),
          ),

          TextButton(
            onPressed: () {
              final String contractName = contractNameController.text;
              if (contractName.isNotEmpty) {
                String? fileContent; // Add logic to read the file content as a string

                Contract newContract = Contract(
                  id: 4,
                  landlordId: 2,
                  name: contractName,
                  content: fileContent ?? 'Nội dung hợp đồng không có',
                );

                addContract(newContract);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập tên hợp đồng')),
                );
              }
            },
            child: const Text('Tích hợp chữ ký số'),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: const Text('Close'),
          ),
        ],
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
          child: const FilePickerDialog(),
        ),
      );
    },
  );
}
