// ignore_for_file: avoid_function_literals_in_foreach_calls


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_category.dart';

import 'package:student_app/config/string/string_utility.dart';
import 'package:student_app/model/shop/shop_category.dart';
import 'package:student_app/service/other/data_services.dart';


class ShopCategoryAction {
  final CollectionReference cateCollection =
      FirebaseFirestore.instance.collection(StringCategory.shopCategory);
  static List<ShopCategory> categoryShops = [];
  Future getCategory() async {
    if (categoryShops.isEmpty) {
      QuerySnapshot snapshot = await cateCollection.get();
      snapshot.docs.forEach((element) {
        categoryShops.add(ShopCategory.fromSnapshot(element));
      });
    } else {
      categoryShops = [];
    }
  }

  Future<List<ShopCategory>> getFormFirebase() async {
    final list = await DataServices().getFormJsonStore(
        StringUtility.urlShopCategory, StringCategory.shopCategory);
    return list.map((e) => ShopCategory.fromJson(e)).toList();
  }

  Future addCategory({required ShopCategory category}) async {
    await cateCollection.doc(category.idShopCategory).set(category.toDynamic());
  }
}
