import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/controller/utility.dart';

import '../../config/string/string_shop.dart';

class PattenProductModel {
  String? idPost;
  String? idPattenProduct;
  String? namePattern;
  double? price;
  int? amount;
  String? imageLink;
  DocumentReference? doc;

  PattenProductModel(
      {this.idPost,
      this.idPattenProduct,
      this.namePattern,
      this.price,
      this.imageLink,
      this.amount});

  String showPrice() {
    String priceResult = '';
    if (price != 0) {
      priceResult = priceToVND(price!);
    }
    return priceResult;
  }

  factory PattenProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    PattenProductModel pattenProduct =
        PattenProductModel.fromJson(snapshot.data() as Map<String, dynamic>);
    pattenProduct.doc = snapshot.reference;
    return pattenProduct;
  }

  factory PattenProductModel.fromJson(Map<String, dynamic> responseData) {
    return PattenProductModel(
      idPattenProduct: responseData[Shop.idPattenProduct],
      idPost: responseData[Shop.idPost],
      namePattern: responseData[Shop.namePattern],
      price: (responseData[Shop.price]) is String
          ? double.parse(responseData[Shop.price])
          : (responseData[Shop.price]),
      imageLink: responseData[Shop.imageLink],
      amount: (responseData[Shop.amount]) is String
          ? int.parse(responseData[Shop.amount])
          : (responseData[Shop.amount]),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      idPattenProduct!: {toDynamic()}
    };
    return json;
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Shop.idPost: idPost,
      Shop.namePattern: namePattern,
      Shop.price: price,
      Shop.amount: amount,
      Shop.imageLink: imageLink,
      Shop.idPattenProduct: idPattenProduct,
    };
    return toData;
  }
}
