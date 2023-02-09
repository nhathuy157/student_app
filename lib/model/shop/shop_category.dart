import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_category.dart';
import 'package:student_app/config/string/string_shop.dart';

import '../../config/string/string_app.dart';
import '../../constants/assets_part.dart';

class ShopCategory {
  String? idShopCategory;
  String? name;
  String? image;
  DocumentReference? doc;
  ShopCategory({this.idShopCategory, this.name, this.image});

  factory ShopCategory.fromSnapshot(DocumentSnapshot snapshot) {
    ShopCategory shopCategory =
        ShopCategory.fromJson(snapshot.data() as Map<String, dynamic>);
    shopCategory.doc = snapshot.reference;
    return shopCategory;
  }

  factory ShopCategory.fromJson(Map<String, dynamic> responseData) {
    return ShopCategory(
      idShopCategory: responseData[Shop.idShopCategory],
      name: responseData[Shop.name],
      image: responseData[Shop.imageLink],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      StringCategory.shopCategory: {toDynamic()}
    };
    return json;
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Shop.idShopCategory: idShopCategory,
      Shop.name: name,
      Shop.imageLink: image,
    };
    return toData;
  }
}

// class ListShopCategory {
//   static List<ShopCategory> getList = [
//     ShopCategory(name: StringApp.fashion, image: ImgAssets.icFashion),
//     ShopCategory(name: StringApp.wareHouse, image: ImgAssets.icWareHouse),
//     ShopCategory(name: StringApp.leaningTool, image: ImgAssets.icLeaningTool),
//     ShopCategory(name: StringApp.tool, image: ImgAssets.icTool),
//     ShopCategory(name: StringApp.tech, image: ImgAssets.icTech),
//   ];
// }
