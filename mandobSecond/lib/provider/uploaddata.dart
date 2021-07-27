import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadData extends ChangeNotifier {
  File img;
  String imgname;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile() async {
    String url = "";

    Reference ref = firebaseStorage.ref().child(imgname);

    UploadTask uploadTask = ref.putFile(img);

    await uploadTask.whenComplete(() async {
      print("task comp");

      url = await uploadTask.snapshot.ref.getDownloadURL();

      notifyListeners();
    });
    return url;
  }

  Future<List<String>> chooseImage(ImageSource imgsrc) async {
    PickedFile file;

    try {
      file = await ImagePicker().getImage(source: imgsrc);

      if (file.path != null) {
        img = File(file.path);
      } else {
        print("no file selected");
      }
    } catch (e) {
      print("error open gallary or camera");
      // return;
    }

    imgname = file.path.split("/").last;
    notifyListeners();
    return [imgname, file.path];
  }

  Future deleteImg(String url) async {
    final ref = await firebaseStorage.refFromURL(url);
    ref.delete();
    print("data deleted successfully");
  }
}
