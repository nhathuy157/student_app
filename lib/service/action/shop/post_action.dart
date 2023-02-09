// ignore_for_file: avoid_function_literals_in_foreach_calls


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/service/action/shop/product_action.dart';

import '../../../config/string/string_shop.dart';
import '../../../model/shop/post_model.dart';

class PostAction {
  int limit = 25;
  static List<PostModel> posts = [];
  static List<PostModel> result = [];
  static CollectionReference reference =
      FirebaseFirestore.instance.collection(Shop.post);
  Future getByProduct({required DocumentReference reference}) async {
    // ignore: unused_local_variable
    QuerySnapshot snapshot = await reference
        .collection(Shop.post)
        .where(
          Shop.status,
          isEqualTo: true,
        )
        .get();
    if (snapshot.docs.isEmpty) {
      posts = [];
    } else {
      getFormSnapShot(snapshot);
    }
  }

  Future<PostModel> getByDoc(DocumentReference doc) async {
    DocumentSnapshot<Object?> snapshot = await doc.get();
    return PostModel.fromSnapshot(snapshot);
  }

  Future addPostV2({required PostModel post, required String idProduct}) async {
    return await FirebaseFirestore.instance
        .collection(Shop.post)
        .doc(post.idPostModel)
        .set(post.toDynamic());
  }

  Future addPost({required PostModel post}) async {
    return await FirebaseFirestore.instance
        .collection(Shop.productSell)
        .doc(post.idProduct)
        .collection(Shop.post)
        .doc(post.idPostModel)
        .set(post.toDynamic());
  }

  Future<List<PostModel>> getNewPosts() async {
    QuerySnapshot snapshot = await ProductAction.reference
        .orderBy(Shop.dayUp, descending: true)
        .limitToLast(limit)
        .get()
        .then(
          (value) => getFormSnapShot(value),
        );
    return posts;
  }

  isExits(String idPostModel) {
    int index =
        posts.indexWhere((element) => element.idPostModel == idPostModel);
    if (index >= 0) {
      return index;
    }

    return -1;
  }

  getFormDocSnapShot(QueryDocumentSnapshot snapshot) {
    PostModel post = PostModel.fromSnapshot(snapshot);

    int location = isExits(post.idPostModel!);
    if (location < 0) {
      posts.add(post);
    } else {
      posts[location] = post;
    }
  }

  getFormSnapShot(QuerySnapshot snapshot) {
    snapshot.docs.forEach((element) {
      PostModel post = PostModel.fromSnapshot(element);
      int location = isExits(post.idPostModel!);
      if (location < 0) {
        posts.add(post);
      } else {
        posts[location] = post;
      }
    });
    return snapshot;
  }

}
