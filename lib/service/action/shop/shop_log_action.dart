import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_app/constants/constant.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/model/shop/shop_log.dart';

import '../../../config/string/string_shop.dart';

class ShopLogAction {
  static List<ShopLog> shopLogs = [];
  static Map<String, bool> mapLastProduct = {};

  CollectionReference reference =
      FirebaseFirestore.instance.collection(Shop.logShop);
  Future getByCategoryNew() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Shop.logShop)
        .orderBy(Shop.dayUp, descending: true)
        .limit(LIMIT + 1)
        .get();
    return getFormSnapshot(snapshot, getLast: true);
  }
  
  List<ShopLog> getFormSnapshot(QuerySnapshot snapshot,
      {bool getLast = false}) {
    shopLogs = [];
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((element) {
        shopLogs.add(ShopLog.fromSnapshot(element));
      });
    } else {
      shopLogs = [];
    }
    if (getLast) {
      checkLast(shopLogs);
    }
    return shopLogs;
  }

  void checkLast(List<ShopLog> list) {
    if (list.length > LIMIT) {
      shopLogs.removeLast();
      mapLastProduct[ProductPostController().idShopCategory] = false;
    } else {
      mapLastProduct[ProductPostController().idShopCategory] = true;
    }
  }

  Future getMore(
      {String idCategory = Shop.idNew, required String idPostLast}) async {
    DocumentSnapshot query = await FirebaseFirestore.instance
        .collection(Shop.logShop)
        .doc(idPostLast)
        .get();
    if (idCategory == Shop.idNew) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(Shop.logShop)
          .orderBy(Shop.dayUp, descending: true)
          .startAfterDocument(query)
          .limit(LIMIT + 1)
          .get();
      return getFormSnapshot(snapshot, getLast: true);
    } else {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(Shop.logShop)
          .orderBy(Shop.dayUp, descending: true)
          .where(Shop.idShopCategory, isEqualTo: idCategory)
          .startAfterDocument(query)
          .limit(LIMIT + 1)
          .get();
      return getFormSnapshot(snapshot, getLast: true);
    }
  }

  Future getNewById(
      {String idCategory = Shop.idNew, required String idPostNew}) async {
    if (idPostNew != "") {
      DocumentSnapshot query = await FirebaseFirestore.instance
          .collection(Shop.logShop)
          .doc(idPostNew)
          .get();
      if (idCategory == Shop.idNew) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(Shop.logShop)
            .orderBy(Shop.dayUp, descending: true)
            .endBeforeDocument(query)
            .get();
        return getFormSnapshot(snapshot);
      } else {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(Shop.logShop)
            .orderBy(Shop.dayUp, descending: true)
            .where(Shop.idShopCategory, isEqualTo: idCategory)
            .endBeforeDocument(query)
            .get();
        return getFormSnapshot(snapshot);
      }
    }
    getByCategory(idCategory: idCategory);
  }

  Future getByCategory({required String idCategory}) async {
    shopLogs = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(
          Shop.logShop,
        )
        .orderBy(Shop.dayUp, descending: true)
        .where(Shop.idShopCategory, isEqualTo: idCategory)
        .limit(LIMIT)
        .get();
    return getFormSnapshot(snapshot, getLast: true);
  }

  // Future getByDoc(String  idLog, String idCategory) async {
  //   DocumentSnapshot afterDoc = await reference.doc(idLog).get();
  //   QuerySnapshot snapshot = reference.orderBy(Shop.dayUp).limit(limit).startAfter(afterDoc)

  //   if (snapshot.docs.isNotEmpty) {
  //     snapshot.docs.forEach((element) {
  //       shopLogs.add(ShopLog.fromSnapshot(element));
  //     });
  //   } else {
  //     shopLogs = [];
  //   }
  // }

  Future addShopLog(ShopLog shopLog) async {
    return await reference.doc(shopLog.idPost).set(shopLog.toDynamic());
  }
}
