import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_shop.dart';

class ShopLog {
  DateTime? dayUp;
  String? idCategory;
  String? idPost;
  String? nameProduct;
  DocumentReference? docPost;
  DocumentReference? docProduct;

  ShopLog(
      {
        this.dayUp,
      this.idCategory,
      this.idPost,
      this.docPost,
      this.docProduct});

  factory ShopLog.fromSnapshot(DocumentSnapshot snapshot) {
    ShopLog shopLog = ShopLog.fromJson(snapshot.data() as Map<String, dynamic>);

    return shopLog;
  }

  factory ShopLog.fromJson(Map<String, dynamic> responseData) {
    return ShopLog(
      idPost: responseData[Shop.idPost],
      docPost: responseData[Shop.docPost],
      docProduct: responseData[Shop.docProduct],
      idCategory: responseData[Shop.idShopCategory],
      dayUp: DateTime.fromMicrosecondsSinceEpoch(
          responseData[Shop.dayUp].microsecondsSinceEpoch),
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      idPost!: {toDynamic()}
    };
    return json;
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Shop.idPost: idPost,
      Shop.docPost: docPost,
      Shop.docProduct: docProduct,
      Shop.idShopCategory: idCategory,
      Shop.dayUp: dayUp,
    };
    return toData;
  }
}
