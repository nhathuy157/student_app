import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_shop.dart';

class ImageProduct {
  String? idProduct;
  String? idPost;
  String? imageLink;
  DocumentReference? doc;

  ImageProduct({this.idProduct, this.imageLink, this.idPost});

  factory ImageProduct.fromSnapshot(DocumentSnapshot snapshot) {
    ImageProduct imgProduct =
        ImageProduct.fromJson(snapshot.data() as Map<String, dynamic>);
    imgProduct.doc = snapshot.reference;
    return imgProduct;
  }
  factory ImageProduct.fromJson(Map<String, dynamic> responseData) {
    return ImageProduct(
      idProduct: responseData[Shop.idProduct],
      idPost: responseData[Shop.idPost],
      imageLink: responseData[Shop.imageLink],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      Shop.imageProduct: {toDynamic()}
    };
    return json;
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Shop.idProduct: idProduct,
      Shop.idPost: idPost,
      Shop.imageLink: imageLink,
    };
    return toData;
  }
}
