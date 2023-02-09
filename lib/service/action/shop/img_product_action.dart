import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_category.dart';
import 'package:student_app/config/string/string_shop.dart';
import 'package:student_app/model/shop/image_product.dart';
import 'package:student_app/model/shop/product_sell_model.dart';
import 'package:student_app/service/other/img_action.dart';
import 'package:uuid/uuid.dart';

class ImgProductAction {
  static List<ImageProduct> imgProduct = [];
  Future getByProduct({required DocumentReference reference}) async {
    QuerySnapshot snapshot =
        await reference.collection(Shop.imageProduct).get();
    if (snapshot.docs.isEmpty) {
      imgProduct = [];
    } else {
      // ignore: avoid_function_literals_in_foreach_calls
      snapshot.docs.forEach((element) {
        imgProduct.add(ImageProduct.fromSnapshot(element));
      });
    }
  }

  Future addProductImg(
      {required ImageProduct imageProduct,
      required DocumentReference reference,
      required File file,
      required String idCategoryShop}) async {
    imageProduct.imageLink = await ImgAction().uploadPicPost(
        file: file,
        idProduct: imageProduct.idProduct!,
        idPost: imageProduct.idPost!,
        idCategoryShop: idCategoryShop);
    await reference.collection(Shop.imageProduct).add(imageProduct.toDynamic());
  }

  Future addImgDefault(
      {required ImageProduct imageProduct,
      required ProductSellModel productSell}) async {
    await FirebaseFirestore.instance
        .collection(StringCategory.shopCategory)
        .doc(productSell.idShopCategory)
        .collection(Shop.productSell)
        .doc(productSell.idProduct)
        .collection(Shop.defaultImages)
        .doc(const Uuid().v1())
        .set(imageProduct.toDynamic());
  }
}
