// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_info.dart';
import 'package:student_app/config/string/string_price.dart';
import 'package:student_app/model/users/user_detail.dart';
import 'package:student_app/controller/utility.dart';

import '../../config/string/string_shop.dart';

class PostModel {
  String? idProduct;
  String? idUser;
  Contact? idContact;
  Contact? contact;
  String? idPostModel;
  double? priceHight;
  double? priceLow;
  String? idRangeMoney;
  bool? status;
  List<String>? imgUser;
  DateTime? dateUp;
  int? limit;
  DocumentReference? doc;
  // List<PattenProductModel>? patternProducts;

  PostModel({
    this.idPostModel,
    this.idProduct,
    this.idUser,
    this.priceHight,
    this.priceLow,
    this.idContact,
    this.contact,
    this.status,
    this.dateUp,
    this.limit,
    this.imgUser,
    this.idRangeMoney,
    // this.imgUser,
    // this.patternProducts,
  });

  String ShowPrice() {
    String price = '';
    if (priceHight != 0) {
      price = '~ ${priceToVND(priceHight!)}';
    }
    price = '${priceToVND(priceLow!)} ${price}';
    return price;
  }

  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> temp = snapshot.data() as Map<String, dynamic>;
    PostModel post = PostModel.fromJson(temp);
    post.doc = snapshot.reference;
    post.imgUser = List.from(snapshot[Shop.image]);
    return post;
  }
  

  factory PostModel.fromJson(Map<String, dynamic> responseData) {
    return PostModel(
        idProduct: responseData[Shop.idProduct],
        idPostModel: responseData[Shop.idPost],
        idUser: responseData[Shop.idUser],
        priceHight: responseData[Shop.priceHight] is String
            ? double.parse(responseData[Shop.priceHight])
            : responseData[Shop.priceHight],
        priceLow: responseData[Shop.priceLow] is String
            ? double.parse(responseData[Shop.priceLow])
            : responseData[Shop.priceLow],
        status: responseData[Shop.status],
        limit: responseData[Shop.limit] is String
            ? int.parse(responseData[Shop.limit])
            : responseData[Shop.limit],
        dateUp: responseData[Shop.dayUp] == null
            ? DateTime.now()
            : DateTime.fromMicrosecondsSinceEpoch(
                responseData[Shop.dayUp].microsecondsSinceEpoch),
        idContact: responseData[StringInfo.idContact],
        idRangeMoney: responseData[StringPrice.idRangeMoney]
        // patternProducts: responseData.entries
        //     .map<PattenProductModel>(
        //         (e) => PattenProductModel.fromJson(e.key, e.value))
        //     .toList(),
        );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {idPostModel!: toDynamic()};
    return json;
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Shop.idPost: idPostModel,
      Shop.idProduct: idProduct,
      Shop.idUser: idUser,
      Shop.priceHight: priceHight,
      Shop.priceLow: priceLow,
      Shop.status: status,
      Shop.dayUp: dateUp,
      Shop.image: imgUser,
      StringInfo.idContact: idContact,
      StringPrice.idRangeMoney: idRangeMoney,
      // Shop.pattenProduct: [
      //   for (var patternProduct in patternProducts!)
      //     {patternProduct.idPostModel: patternProduct.toDynamic()}
      // ]
    };
    return toData;
  }

  List<dynamic> getPropertiesObject() {
    List<dynamic> toData = [
      idProduct!,
      idUser!,
      priceHight,
      priceLow,
      status,

      //    imgUser,
    ];
    return toData;
  }
}
