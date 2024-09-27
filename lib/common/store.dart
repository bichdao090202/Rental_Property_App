import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';



final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
final file = File('path/to/image.jpg');
final uploadTask = storageRef.child('images/image.jpg').putFile(file);

final imagesRef = storageRef.child("images");
final spaceRef = storageRef.child("images/space.jpg");
final mountainsRef = storageRef.child("mountains.jpg");
final mountainImagesRef = storageRef.child("images/mountains.jpg");
//rental-room-app-cf629 Rental-room-app
//https://console.firebase.google.com/project/rental-room-app-cf629/overview
//https://console.firebase.google.com/project/rental-room-app-cf629/storage/rental-room-app-cf629.appspot.com/files
//https://console.firebase.google.com/project/rental-room-app-cf629/settings/general/web:MDA2NTc1N2EtMDcyNy00OGQzLTg5Y2MtMDg4ZWViNmI4NjE5
Future<void> uploadFile() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.absolute}/file-to-upload.png';
  File file = File(filePath);
  try {
    await mountainsRef.putFile(file);
  } on FirebaseException catch (e) {
    // ...
  }
}