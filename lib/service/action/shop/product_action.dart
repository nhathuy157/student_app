// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_shop.dart';

import '../../../model/shop/product_sell_model.dart';

class ProductAction {
  static const limitResult = 25;
  static List<ProductSellModel> products = [];
  static CollectionReference reference =
      FirebaseFirestore.instance.collection(Shop.productSell);
  Future getByCategoryId({required String idCategory}) async {
    QuerySnapshot snapshot = await reference
        .doc(idCategory)
        .collection(Shop.productSell)
        .where(
          Shop.numberPosts,
          isGreaterThan: 0,
        )
        .limit(limitResult)
        .get();
    if (snapshot.docs.isEmpty) {
      products = [];
    } else {
      snapshot.docs.forEach((element) {
        products.add(ProductSellModel.fromSnapshot(element));
      });
    }
  }

  Future getByDoc(DocumentReference doc) async {
    DocumentSnapshot<Object?> snapshot = await doc.get();
    return ProductSellModel.fromSnapshot(snapshot);
  }

  Future getById({required String idProduct}) async {
    int location = getLocationByProductId(idProduct);
    if (location >= 0) {
      return products[location];
    }

    DocumentSnapshot<Object?> snapshot = await reference.doc(idProduct).get();
    getFormDocSnapShot(snapshot);
    products.last;
    return snapshot;
  }

  Future getDocById({required String idProduct}) async {
    DocumentReference doc = reference.doc(idProduct);
    return doc;
  }

  Future updateProduct({required ProductSellModel product}) async {
    return await FirebaseFirestore.instance
        .collection(Shop.productSell)
        .doc(product.idProduct)
        .set(product.toDynamic());
  }

  Future addProduct({required ProductSellModel product}) async {
    return await FirebaseFirestore.instance
        .collection(Shop.productSell)
        .doc(product.idProduct)
        .set(product.toDynamic());
  }

  getLocationByProductId(String idProduct) {
    int index =
        products.indexWhere((element) => element.idProduct == idProduct);
    if (index >= 0) {
      return index;
    }
    return -1;
  }

  getFormDocSnapShot(DocumentSnapshot snapshot) {
    ProductSellModel productSellModel = ProductSellModel.fromSnapshot(snapshot);
    int location = getLocationByProductId(productSellModel.idProduct!);
    if (location < 0) {
      products.add(productSellModel);
    } else {
      products[location] = productSellModel;
    }
  }

  Future getFormSnapShot(QuerySnapshot snapshot) async {
    snapshot.docs.forEach((element) {
      ProductSellModel productSellModel =
          ProductSellModel.fromSnapshot(element);
      int location = getLocationByProductId(productSellModel.idProduct!);
      if (location < 0) {
        products.add(productSellModel);
      } else {
        products[location] = productSellModel;
      }
    });
    return products;
  }
}
