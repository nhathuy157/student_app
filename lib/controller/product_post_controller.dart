import 'package:flutter/cupertino.dart';
import 'package:student_app/model/shop/product_post.dart';
import 'package:student_app/model/shop/shop_log.dart';

import '../config/string/string_shop.dart';
import '../model/shop/post_model.dart';
import '../model/shop/product_sell_model.dart';
import '../service/action/shop/post_action.dart';
import '../service/action/shop/product_action.dart';
import '../service/action/shop/shop_category.dart';
import '../service/action/shop/shop_log_action.dart';

class ProductPostController extends ChangeNotifier {
  static List<ProductPost> productPosts = [];
  static Map<String, List<ProductPost>> mapProductPost = {};
  static ProductPost? productPostSelected;
  // static List<PattenProductModel> patternProductModelSelected = [];

  static final ProductPostController _singleton =
      ProductPostController._internal();

  factory ProductPostController() {
    return _singleton;
  }
  ProductPostController._internal();
  bool isLoading = true;
  String _idCategory = Shop.idNew;
  String get idShopCategory => _idCategory;
  set idShopCategory(String idCategory) {
    _idCategory = idCategory;
    isLoading = true;
    notifyListeners();
  }

  getById(String idPost) {
    int index = productPosts
        .indexWhere((element) => element.post!.idPostModel == idPost);
    if (index < 0) {
      return null;
    }
    return productPosts[index];
  }

  ProductPost getByIdPatternProduct(String idPostInPattern) {
    int index = productPosts.indexWhere((element) {
      return element.post!.idPostModel == idPostInPattern;
    });
    return productPosts[index];
  }

  Future getProductPostNew(String idCategory) async {
    if (!mapProductPost.containsKey(idCategory)) {
      if (idCategory == Shop.idNew) {
        mapProductPost[idCategory] =
            await setProductPosts(await ShopLogAction().getByCategoryNew());
      } else {
        mapProductPost[idCategory] = await setProductPosts(
            await ShopLogAction().getByCategory(idCategory: idCategory));
      }
    }
    productPosts = mapProductPost[idCategory] as List<ProductPost>;

    return productPosts;
  }

  Future getMoreProductPost(String idCategory) async {
    List<ProductPost> list = await setProductPosts(await ShopLogAction()
        .getMore(
            idCategory: idCategory,
            idPostLast: productPosts.last.post!.idPostModel!));
    if (list.isNotEmpty) {
      productPosts.addAll(list);
      mapProductPost[idCategory] = productPosts;
    }

    return mapProductPost[idCategory] as List<ProductPost>;
  }

  Future getNew(String idCategory) async {
    List<ProductPost> list = await setProductPosts(await ShopLogAction()
        .getNewById(
            idCategory: idCategory,
            idPostNew: productPosts[0].post!.idPostModel!));
    if (list.isNotEmpty) {
      list.addAll(productPosts);
      mapProductPost[idCategory] = list;
    }
    return mapProductPost[idCategory] as List<ProductPost>;
  }

  Future setProductPosts(List<ShopLog> log) async {
    if (log == null) return [];
    List<ProductPost> productPosts = [];
    for (var log in ShopLogAction.shopLogs) {
      final post = await PostAction().getByDoc(log.docPost!);
      final product = await ProductAction().getByDoc(log.docProduct!);
      productPosts.add(ProductPost(post: post, product: product));
    }
    productPosts.sort((a, b) => b.post!.dateUp!.compareTo(a.post!.dateUp!));
    return productPosts;
  }

  Map<String, List<ProductPost>> newCategory(
      String id, List<ProductPost> list) {
    return {id: list};
  }

  addMapProductPost() {
    if (mapProductPost.isEmpty) {
      for (var element in ShopCategoryAction.categoryShops) {
        mapProductPost["${element.idShopCategory}"] = [];
      }
    }
  }

  Future getNewByCategory(String idStart) async {
    await PostAction().getNewPosts();
    return getProduct();
  }

  Future getNewBy(String idStart) async {
    await PostAction().getNewPosts();
    return getProduct();
  }

  Future getProduct() async {
    List<ProductPost> productPosts = [];
    for (PostModel post in PostAction.posts) {
      ProductSellModel productSellModel =
          await ProductAction().getById(idProduct: post.idProduct!);
      if (getLocation(post.idPostModel!) < 0) {
        productPosts.add(ProductPost(post: post, product: productSellModel));
      }
    }
    return productPosts;
  }

  getLocation(String idPost) {
    int index = productPosts
        .indexWhere((element) => element.post!.idPostModel == idPost);
    if (index < 0) {
      return -1;
    }
    return index;
  }
}
