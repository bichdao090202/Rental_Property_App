import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Future<String> encodeFileToBase64(String filePath) async {
  try {
    final File file = File(filePath);
    Uint8List fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    return base64String;
  } catch (e) {
    throw Exception('Lỗi khi encode file PDF: $e');
  }
}

Future<void> decodeBase64ToFile(String base64String, String outputPath) async {
  try {
    Uint8List fileBytes = base64Decode(base64String);
    final File file = File(outputPath);
    await file.writeAsBytes(fileBytes);
  } catch (e) {
    throw Exception('Lỗi khi decode file PDF: $e');
  }
}
