// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_app/config/string/string_category.dart';
import 'package:student_app/config/string/string_shop.dart';
import 'package:uuid/uuid.dart';

class ImgAction {
  Reference reference = FirebaseStorage.instance.ref();
  static const String imgRoot = 'img';
  static const String imgCategoryShop =
      '$imgRoot/${StringCategory.shopCategory}}/';

  Future uploadPicCategoryShop({required File file}) async {
    String path = '$imgCategoryShop/';
    UploadTask uploadTask = reference.child(imgCategoryShop).putFile(file);
    return getURLUpload(uploadTask, path);
  }

  Future uploadPicProduct(
      {required File file,
      required String idProduct,
      required String idCategoryShop}) async {
    String path = '$imgCategoryShop/$idCategoryShop/$idProduct';
    UploadTask uploadTask = reference
        .child('$imgCategoryShop/$idCategoryShop/$idProduct')
        .putFile(file);
    return getURLUpload(uploadTask, path);
  }

  Future uploadPicPost(
      {required File file,
      required String idProduct,
      required String idCategoryShop,
      required String idPost}) async {
    String path = '$imgCategoryShop/$idCategoryShop/$idProduct/$idPost';
    UploadTask uploadTask = reference
        .child('$imgCategoryShop/$idCategoryShop/$idProduct/$idPost')
        .putFile(file);
    return getURLUpload(uploadTask, path);
  }

  Future getURLUpload(UploadTask uploadTask, String path) async {
    print("task done");
    if (uploadTask.snapshot.state == TaskState.success) {
      FirebaseStorage.instance.ref().child(path).getDownloadURL().then((url) {
        print("Here is the URL of Image $url");
        return url;
      }).catchError((onError) {
        print("Got Error $onError");
      });
    }
  }

  Future<File> getImageFileFromAssets(
      {required String imageName,
      required String ext,
      required fileName}) async {
    var bytes = await rootBundle.load('images/$imageName.$ext');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$fileName.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  Future uploadImagesFirebase({
    required String pathStorage,
    required String assets,
  }) async {
    String imageName =
        assets.substring(assets.lastIndexOf("/") + 1, assets.lastIndexOf("."));
    final String name = Uuid().v1();
    final Directory systemTempDir = Directory.systemTemp;
    final byteData = await rootBundle.load(assets);
    final file = File('${systemTempDir.path}/$imageName');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    TaskSnapshot taskSnapshot =
        await FirebaseStorage.instance.ref('$pathStorage/$name').putFile(file);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
