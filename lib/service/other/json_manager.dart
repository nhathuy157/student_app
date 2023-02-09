import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/hotel/category_capacity_hotel.dart';
import 'package:student_app/model/other/range_money.dart';
import 'package:student_app/model/shop/post_model.dart';
import 'package:student_app/model/shop/product_sell_model.dart';
import 'package:student_app/model/shop/shop_category.dart';
import 'package:student_app/model/users/user_detail.dart';
import 'package:student_app/service/other/data_services.dart';

import '../../model/shop/patten_product_model.dart';

class JsonManager {
  Map<String, dynamic> categoriesToJson(
      {required nameCategory, required List<dynamic> list}) {
    return {
      nameCategory: list.map((e) => e.toDynamic()).toList(),
    };
  }

  Future<List<ShopCategory>> readJsonShopCategory() async {
    final jsonData = await rootBundle.loadString(DataAssets.shop_category);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => ShopCategory.fromJson(e)).toList();
  }

  Future<List<ProductSellModel>> readJsonShopProduct() async {
    final jsonData = await rootBundle.loadString(DataAssets.product);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => ProductSellModel.fromJson(e)).toList();
  }

  Future<List<PostModel>> readJsonShopPost() async {
    final jsonData = await rootBundle.loadString(DataAssets.post);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<List<PattenProductModel>> readJsonShopPattern() async {
    final jsonData = await rootBundle.loadString(DataAssets.pattern);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => PattenProductModel.fromJson(e)).toList();
  }

  Future<List<Contact>> readJsonContact() async {
    final jsonData = await rootBundle.loadString(DataAssets.contact);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => Contact.fromJson(e)).toList();
  }

  Future<List<RangeMoney>> readJsonRangeMoney() async {
    final jsonData = await rootBundle.loadString(DataAssets.rangeMoney);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => RangeMoney.fromJson(e)).toList();
  }

  Future<List<dynamic>> categoryFormFireBase(
      {required String url, required String nameType}) async {
    return await DataServices().getFormJsonStore(url, nameType);
  }

  bool _fileExists = false;
  late File _filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  void writeJson(Map<String, dynamic> value, String fileName) async {
    _filePath = await _localFile(fileName);
    String _jsonString = jsonEncode(value);
    _filePath.writeAsString(_jsonString);
  }

  Future readJson(String fileName) async {
    _filePath = await _localFile(fileName);
    _fileExists = await _filePath.exists();
    if (_fileExists) {
      try {
        String _jsonString = await _filePath.readAsString();
        return jsonDecode(_jsonString);
      } catch (e) {
        return {};
      }
    }
  }
}
