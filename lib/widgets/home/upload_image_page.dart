// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart'; // Thêm file_picker
//
// class UploadImagePage extends StatefulWidget {
//   final String imagePath; // Đường dẫn đến file hình ảnh
//
//   UploadImagePage({required this.imagePath});
//
//   @override
//   _UploadImagePageState createState() => _UploadImagePageState();
// }
//
// class _UploadImagePageState extends State<UploadImagePage> {
//   final storage = FirebaseStorage.instance;
//   File? _image;
//   String? _downloadUrl;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImageFromPath(); // Load hình ảnh từ đường dẫn khi khởi tạo
//   }
//
//   Future<void> _loadImageFromPath() async {
//     try {
//       _image = File(widget.imagePath);
//     } catch (e) {
//       print('Lỗi khi tải hình ảnh: $e');
//     }
//   }
//
//   Future<void> _pickImage() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.image, // Chỉ cho phép chọn file hình ảnh
//       );
//       if (result != null) {
//         setState(() {
//           _image = File(result.files.single.path!);
//         });
//       }
//     } catch (e) {
//       print('Lỗi khi chọn hình ảnh: $e');
//     }
//   }
//
//   Future<void> _uploadImage() async {
//     if (_image != null) {
//       final storageRef = storage.ref();
//       final uploadTask = storageRef.child('images/${_image!.path}').putFile(_image!);
//       await uploadTask.then((value) => value.ref.getDownloadURL()).then((url) {
//         setState(() {
//           _downloadUrl = url;
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Image'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_image != null)
//               Image.file(_image!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage, // Thay đổi thành _pickImage
//               child: Text('Chọn hình ảnh'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadImage,
//               child: Text('Upload Image'),
//             ),
//             SizedBox(height: 20),
//             if (_downloadUrl != null)
//               Text('Download URL: $_downloadUrl'),
//           ],
//         ),
//       ),
//     );
//   }
// }
