import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as dev;

class DataServices {
  Future uploadToStorage(
      Map<String, dynamic> value, String path, String fileName) async {
    var jsonString = jsonEncode(value);
    var bytes = utf8.encode(jsonString);
    var base64Str = base64.encode(bytes);
    var arr = base64.decode(base64Str);
    TaskSnapshot taskSnapshot =
        await FirebaseStorage.instance.ref('$path/$fileName').putData(arr);
    var downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  Future<http.Response> getJsonURL(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future<List<dynamic>> getFormJsonStore(String url, String typeParse) async {
    final response = await getJsonURL(url);
    final pasred =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return pasred[typeParse] as List;
  }
}
