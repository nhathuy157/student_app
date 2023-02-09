import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/controller/utility.dart';
import 'package:student_app/model/shop/patten_product_model.dart';
import 'package:student_app/model/shop/post_model.dart';
import 'package:student_app/service/action/shop/product_action.dart';

import '../../../config/string/string_shop.dart';
import 'dart:developer' as devtools show log;

class PatternProductAction {
  static List<PattenProductModel> pattenProducts = [];
  // static PattenProductModel patternProductSelected =
  //     CartController.patternProductModels[0];

  Future addPatternProduct(
      PostModel postModel, PattenProductModel pattenProductModel) async {
    return await ProductAction.reference
        .doc(postModel.idProduct)
        .collection(Shop.post)
        .doc(postModel.idPostModel)
        .collection(Shop.pattenProduct)
        .doc(pattenProductModel.idPattenProduct)
        .set(pattenProductModel.toDynamic());
  }

  Future getPatternProductFromFirebase(PostModel postModel) async {
    // ignore: unused_local_variable
    QuerySnapshot snapshot = await ProductAction.reference
        .doc(postModel.idProduct)
        .collection(Shop.post)
        .doc(postModel.idPostModel)
        .collection(Shop.pattenProduct)
        .get();
    if (snapshot.docs.isEmpty) {
      devtools.log('hello bugs');
      return;
    } else {
      getFromSnapShot(snapshot);
      return pattenProducts;
    }
  }

  getFromSnapShot(QuerySnapshot snapshot) {
    pattenProducts.clear();
    for (var element in snapshot.docs) {
      devtools.log(element.data().toString());
      pattenProducts.add(
          PattenProductModel.fromJson(element.data() as Map<String, dynamic>));
    }

    for (var element in pattenProducts) {
      devtools.log(element.amount.toString());
    }
  }

  String ShowPrice(double priceInput) {
    String price = '';
    if (priceInput != 0) {
      price = '~ ${priceToVND(priceInput)}';
    }
    return price;
  }

  int findAmountMaxPatternOrigin(
    PattenProductModel pattenProductModel,
  ) {
    int index = pattenProducts.indexWhere((element) {
      devtools.log("id trong lap " + element.idPattenProduct.toString());
      devtools.log("amoung trong lap " + element.amount.toString());
      return element.idPattenProduct == pattenProductModel.idPattenProduct!;
    });
    devtools.log(
        "id thang truyen do " + pattenProductModel.idPattenProduct.toString());
    devtools
        .log("amount max tinh lai " + pattenProducts[index].amount!.toString());
    return pattenProducts[index].amount!;
  }
}
