import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    await storage.ref('img/${image.name}').putFile(File(image.path));
  }

  Future<String> downloadUrl(String imageName) async {
    String downloadUrl =
    await storage.ref('img/${imageName}').getDownloadURL();
    return downloadUrl;
  }
}
