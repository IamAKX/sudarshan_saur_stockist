import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> uploadEventImage(
      File file, String fileName, String folder) async {
    String path = '$folder/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask? uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadLink = await snapshot.ref.getDownloadURL();
    return downloadLink;
  }

  static Future<String> uploadProfileImage(File file, String userId) async {
    String path =
        '$userId/profileImane/${file.path.split(Platform.pathSeparator).last}';
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask? uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadLink = await snapshot.ref.getDownloadURL();
    return downloadLink;
  }
}
