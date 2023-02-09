import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/model/shop/post_model.dart';

import '../../config/string/string_shop.dart';
import '../../config/string/string_utility.dart';
import '../../controller/utility.dart';

class ProductSellModel {
  String? idShopCategory;
  String? idProduct;
  String? nameProduct;
  String? description;
  int? numberPosts;
  DocumentReference? documentReference;
  List<String>? imagesProduct = [];
  List<PostModel>? posts;

  ProductSellModel({
    this.idShopCategory,
    this.idProduct,
    this.nameProduct,
    this.description,
    this.numberPosts,
  });

  factory ProductSellModel.fromSnapshot(DocumentSnapshot snapshot) {
    ProductSellModel productSellModel =
        ProductSellModel.fromJson(snapshot.data() as Map<String, dynamic>);
    productSellModel.documentReference = snapshot.reference;
    productSellModel.imagesProduct = List.from(snapshot[Shop.image]);
    return productSellModel;
  }

  factory ProductSellModel.fromJson(Map<String, dynamic> responseData) {
    return ProductSellModel(
      idShopCategory: responseData[Shop.idShopCategory],
      idProduct: responseData[Shop.idProduct],
      nameProduct: responseData[Shop.nameProduct],
      description: responseData[Shop.description],
      numberPosts: responseData[Shop.numberPosts] is String
          ? int.parse(responseData[Shop.numberPosts])
          : responseData[Shop.numberPosts],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      Shop.productSell: {toDynamic()}
    };
    return json;
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Shop.idProduct: idProduct,
      Shop.idShopCategory: idShopCategory,
      Shop.nameProduct: nameProduct,
      Shop.description: description,
      Shop.numberPosts: numberPosts,
      Shop.image: imagesProduct,
      StringUtility.keyWord: getKeyWorld(nameProduct!),
    };

    return toData;
  }

  Map<String, dynamic> getPostJson() {
    Map<String, dynamic> temp = {};
    for (var post in posts!) {
      return post.toJson();
    }
    return temp;
  }

  Map<String, dynamic> getTest() {
    PostModel post;
    for (var post in posts!) {
      //post =
      //  log(post.toJson().toString());
      return {};
    }
    return {};
  }
}
