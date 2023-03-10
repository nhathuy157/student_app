// ignore_for_file: non_constant_identifier_names

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:math';

import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/controller/category_controller.dart';
import 'package:student_app/model/shop/patten_product_model.dart';
import 'package:student_app/model/shop/shop_category.dart';
import 'package:student_app/model/shop/shop_log.dart';
import 'package:student_app/service/other/img_action.dart';
import 'package:student_app/service/other/range_money_action.dart';
import 'package:student_app/service/action/shop/patten_product_acction.dart';
import 'package:student_app/service/action/shop/post_action.dart';
import 'package:student_app/service/action/shop/product_action.dart';
import 'package:student_app/service/action/shop/shop_log_action.dart';
import 'package:uuid/uuid.dart';

import '../../../config/string/string_shop.dart';
import '../../../model/shop/image_product.dart';
import '../../../model/shop/post_model.dart';
import '../../../model/shop/product_sell_model.dart';
import '../../other/json_manager.dart';
import 'shop_category.dart';

class FakeData {
  static List<ShopLog> shopLog = [];
  static List<ShopCategory> categories = [];
  static String stringIdCategory = '';
  static var uuid = const Uuid();
  Future AddData() async {
    categories = await JsonManager().readJsonShopCategory();
    PostAction.posts = await JsonManager().readJsonShopPost();
    // print("log ${PostAction.posts.last.idPostModel}");

    ProductAction.products = await JsonManager().readJsonShopProduct();
    PatternProductAction.pattenProducts =
        await JsonManager().readJsonShopPattern();
  }

  Future setCategory() async {
    await CategoryController().getShopCategory();
    for (var item in categories) {
      item.idShopCategory = await SetProduct(
          item.idShopCategory!,
          CategoryController
              .shopCategories[int.tryParse(item.idShopCategory!) == null
                  ? 0
                  : int.parse(item.idShopCategory!)]
              .idShopCategory!);
    }
  }

  Future setFirebase() async {
    await CategoryFirebase();
    await ProductFireBase();
    await PostFireBase();
    await patternFirebase();
    await ShopLogFirebase();
  }

  Future CategoryFirebase() async {
    for (var element in ShopCategoryAction.categoryShops) {
      await ShopCategoryAction().addCategory(category: element);
    }
  }

  Future ProductFireBase() async {
    for (var element in ProductAction.products) {
      await ProductAction().addProduct(product: element);
    }
  }

  Future PostFireBase() async {
    RangeMoneyAction().getRangeForPost();
    for (var element in PostAction.posts) {
      await PostAction().addPost(post: element);
    }
  }

  Future patternFirebase() async {
    for (var element in PatternProductAction.pattenProducts) {
      int index =
          PostAction.posts.indexWhere((p) => p.idPostModel == element.idPost);
      await PatternProductAction()
          .addPatternProduct(PostAction.posts[index], element);
    }
  }

  Future ShopLogFirebase() async {
    for (var element in ShopLogAction.shopLogs) {
      await ShopLogAction().addShopLog(element);
    }
  }

  Future SetProduct(String idCategory, String idCateogryNew) async {
    if (idCategory == Shop.idNew) return Shop.idNew;
    String idCategoryResult = idCateogryNew;
    int j = 1;
    for (var Product in ProductAction.products) {
      String idProductNew = uuid.v1();
      if (Product.idShopCategory == idCategory) {
        List<String> img = await getImgList(
            idCategory: idCategoryResult,
            idProduct: Product.idProduct!,
            idProductNew: idProductNew);
        final listPost = SetPost(
            Product, idProductNew, uuid.v1(), img.sublist(3), idCategoryResult);
        Product.idProduct = idProductNew;
        Product.idShopCategory = idCategoryResult;
        Product.numberPosts = listPost.length;
        Product.imagesProduct = img.sublist(0, 3);
      }
    }

    return idCategoryResult;
  }

  Future<List<String>> getImgList(
      {required String idProduct,
      required String idProductNew,
      required String idCategory}) async {
    List<String> images = [];
    for (int i = 1; i < 7; i++) {
      String assets = 'assets/images/shop/product/product$idProduct/$i.jpg';
      String pathStorage = '';
      if (i > 3) {
        pathStorage = 'img/category_shop/$idCategory/$idProductNew/default';
      } else {
        pathStorage = 'img/category_shop/$idCategory/$idProductNew/';
      }
      String img = await ImgAction()
          .uploadImagesFirebase(assets: assets, pathStorage: pathStorage);
      images.add(img);
    }
    return images;
  }

  List<PostModel> SetPost(ProductSellModel Product, String idProductNew,
      String idPostNew, List<String> image, String idCategory) {
    final List<PostModel> posts = [];
    double priceLow = 0;
    double priceHight = 0;
    for (var post in PostAction.posts) {
      if (Product.idProduct == post.idProduct) {
        print("log ${post.idPostModel}");
        post.imgUser = image;
        final list = SetPattern(post.idPostModel!, idPostNew, image[0]);
        priceHight = priceLow = list[0].price!;
        for (var pattern in list) {
          if (priceLow < pattern.price!) {
            priceLow = pattern.price!;
          }
          if (priceHight < pattern.price!) {
            priceHight = pattern.price!;
          }
        }
        if (priceHight != priceLow) {
          post.priceHight = priceHight;
          post.priceLow = priceLow;
        } else {
          post.priceHight = 0;
          post.priceLow = priceLow;
        }
        post.dateUp = DateTime.now();
        post.idPostModel = idPostNew;
        post.idProduct = idProductNew;
        print("log ${post.idPostModel}");
        posts.add(post);
        ShopLogAction.shopLogs.add(ShopLog(
            idPost: post.idPostModel,
            idCategory: idCategory,
            dayUp: post.dateUp,
            docProduct: ProductAction.reference.doc(idProductNew),
            docPost: ProductAction.reference
                .doc(idProductNew)
                .collection(Shop.post)
                .doc(idPostNew)));
      }
    }
    return posts;
  }

  static List<PattenProductModel> SetPattern(
      String idPost, String idPostNew, String image) {
    List<PattenProductModel> temp = [];
    for (var e in PatternProductAction.pattenProducts) {
      if (e.idPost == idPost) {
        e.idPost = idPostNew;
        e.idPattenProduct = uuid.v1();
        e.namePattern ??= '';
        e.imageLink = image;
        temp.add(e);
      }
    }
    return temp;
  }

  Future AddProduct() async {
    int j = 1;
    String str = '1';
    FakeData.stringIdCategory = str;
    FakeData.getProductSell().forEach((element) async {
      List<String> list = [];
      for (int i = 1; i < 6; i++) {
        list.add(await AddImg(element, j, i));
      }
      element.imagesProduct = list;
      element.posts = AddPost(element, j);
      await ProductAction().addProduct(product: element);
      for (var item in element.posts!) {
        await PostAction().addPost(post: item);
      }
      j++;
    });
  }

  AddPost(
    ProductSellModel productSellModel,
    int numPic,
  ) {
    List<PostModel> posts = [];
    FakeData.getPost1(productSellModel.idProduct!).forEach((element) {
      element.imgUser = [];
      element.imgUser!.add(productSellModel.imagesProduct![numPic]);
      posts.add(element);
    });
    return posts;
  }

  Future AddImg(ProductSellModel productSellModel, int number, int pic) async {
    ImageProduct img = ImageProduct(idProduct: productSellModel.idProduct);
    String name = const Uuid().v1();
    img.imageLink = await ImgAction().uploadImagesFirebase(
      pathStorage:
          'img/category_shop/${productSellModel.idProduct}/${productSellModel.idProduct}/${Shop.defaultImages}/$name',
      assets: 'assets/images/test/product$number/$pic.png',
    );
    // ImgProductAction()
    //     .addImgDefault(imageProduct: img, productSell: productSellModel);
    return img.imageLink;
  }

  static List<ProductSellModel> getProductSell() {
    return [
      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct: '??o Th???i Trang SaG ch???t li???u cotton 100%',
        description: '''??o th???i trang s???n ph???m m???i Sa.G
??o in l???a . ch???t v??i cotton 100% , c?? gi??n t???t , 
C?? 3 size M L XL
??o form chu???n . ch???t li???u v??i co gi??n , 
Th???i trang , ????n gi??n nh??ng s???n ph???m ??o c???c k?? t???t ''',
        numberPosts: 2,
      ),

      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct:
            'Amazing, th???i trang c??ng s??? cao c???p, ??o s?? mi nam form chu???n, th??n su??ng, v???t b???u, tay d??i, nhi???u m??u, nhi???u size',
        description: '''
1. Th??ng tin s???n ph???m :
1. Th??ng tin s???n ph???m :
 - ch???t li???u : cotton d??y d???n th???m h??t m??? h??i
 - m??u s???c ??o thun nam UNICI c?? : ??en - Tr???ng
 - ??o thun nam UNICI m???m m???i m???c tho???i m??i ph?? h???p cho c??? vi???c ??i ch??i v?? l??m vi???c nh?? c??c b???n 
 - ???????ng may tinh t???, t??? m??? trong t???ng chi ti???t ???? l??m l??n th????ng hi???u c???a th???i trang UNICI 
 - Form su??ng mang l???i s??? tho???i m??i tr?????c v?? sau ?????u in h??nh unisex
 - Ch???t l?????ng s???n ph???m t???t, gi?? c??? h???p l??

2. H?????ng d???n ch???n size: (B???ng size ??o Thun Nam Cao C???p UNICI ch??? mang t??nh ch???t tham kh???o, n???u b???n kh??ng ch???c ch???n v??? size c???a m??nh, h??y nh???n tin ????? shop h??? tr??? b???n nha)
 - Size M: c??n n???ng <50kg, chi???u cao: <1m55 
 - Size L: c??n n???ng: <60kg, Chi???u cao: <1m65 
 - Size XL : c??n n???ng: <70kg, chi???u cao: <1m72        
 - Size XXL: c??n n???ng: <75kg, chi???u cao: <1m80 
 
3. H?????ng d???n ?????T H??NG ???????c FREESHIP 
 -  N???u c??c b???n mua 1 s???n ph???m, vui l??ng ???n mua ngay 
 -  N???u c??c b???n mua t??? 2 s???n ph???m tr??? l??n, vui l??ng ???n th??m v??o gi??? h??ng, v?? l???n l?????t th??m c??c s???n ph???m b???n mu???n mua v??o gi??? tr?????c khi ?????t h??ng v?? thanh to??n. C??c b???n n??n t???n d???ng m?? gi???m gi?? v???n chuy???n c???a shopee b???ng c??ch ?????t ????n h??ng tr??n 150k n???u b???n ??? H?? N???i, tr??n 250k ??? c??c t???nh th??nh c??n l???i nh??, ??i???u n??y s??? gi??p m??nh ti???t ki???m ???????c kha kh?? ti???n ???? ???.''',
        numberPosts: 23,
      ),

      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct:
            'Qu???n t??y ??u cao c???p, th???i trang c??ng s??? kh??ng ly, form d??ng chu???n, h???a ti???t v??n ch??m, c?? size ?????i',
        description:
            '''I???N T???O V??? NGO??I HO??N H???O V???I TH???I TRANG C??NG S??? CAO C???P AMAZING
- Qu???n t??y ??u Amazing, ???????c s???n xu???t tr??n d??y chuy???n c??ng ngh??? cao, t??? m??? t???ng ???????ng kim, m??i ch???, s???c s???o nh?? may ??o.
- M??u ??en v?? xanh ??en navy, l?? d???ng qu???n c??n b???n kh??ng bao gi??? l???i m???t, size s??? ?????y ????? t??? 45kg ?????n 100kg, gi?? tr???, l???n b??, cao th???p, m???p ???m g?? c??ng m???c ???????c. 
- Thi???t k??? qu???n kh??ng ly, form d??ng truy???n th???ng chu???n m???c, l?? iterm thanh l???ch ???????c s??? d???ng h???ng ng??y c???a c??c ch??ng c??ng s??? v??n ph??ng, hay c??c event, d???o ch??i..
- V???i nh???p kh???u tr???c ti???p t??? ???n ?????, ch???t li???u T/R/S (70% Tetron - 28% Rayon - 2% Spandex)
- Qu???n ch??a l??n lai, Qu?? kh??ch vui l??ng ?????o ni ????ng gi??y??? cho chi???c qu???n tr??n 10 ??i???m ho??n h???o nh??! C??c anh qu?? cao hay h??i th???p m???t ch??t c??ng y??n t??m khi mua qu???n n??y nh??.
- H?????NG D???N CH???N SIZE:
????? d??? d??ng ch???n ???????c chi???c qu???n t??y nam v???a v???n v???i m??nh b???n n??n bi???t v??ng eo (v??? tr?? l??ng qu???n m?? b???n th?????ng m???c).
 Vd: v??ng eo c???a b???n l?? 80cm, th??m 2cm c??? ?????ng, b???n n??n ch???n size 31. 
Ch??? s??? c??n n???ng d?????i ????y ch??? mang t??nh tham kh???o, ????? b???n bi???t c??i kho???ng size ph?? h???p v???i m??nh.
Size	C??n n???ng  V??ng eo qu???n th??nh ph???m                                 ''',
        numberPosts: 2,
      ),
      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct: 'k??nh n??? th???i trang',
        description: '''??? ??en ( k??nh c?? tr??ng )

??? B??c n??o c???n mua v??? l???p c???n c??ng ngon l??nh c??nh ????o ???? ???

Gi?? s???n ph???m tr??n Tiki ???? bao g???m thu??? theo lu???t hi???n h??nh. B??n c???nh ????, tu??? v??o lo???i s???n ph???m, h??nh th???c v?? ?????a ch??? giao h??ng m?? c?? th??? ph??t sinh th??m chi ph?? kh??c nh?? ph?? v???n chuy???n, ph??? ph?? h??ng c???ng k???nh, thu??? nh???p kh???u (?????i v???i ????n h??ng giao t??? n?????c ngo??i c?? gi?? tr??? tr??n 1 tri???u ?????ng).....

S???n ph???m n??y l?? t??i s???n c?? nh??n ???????c b??n b???i Nh?? B??n H??ng C?? Nh??n v?? kh??ng thu???c ?????i t?????ng ph???i ch???u thu??? GTGT. Do ???? ho?? ????n VAT kh??ng ???????c cung c???p trong tr?????ng h???p n??y.''',
        numberPosts: 2,
      ),

      //  ProductSellModel(
      //     idShopCategory: 'ce693560-c2ea-11ec-a9ed-d3dae7e8c016',
      //     idProduct: uuid.v1(),
      //     nameProduct: '',
      //     description: '''''',
      //     numberPosts: 2,
      //   ),
    ];
  }

  static List<ShopCategory> getCategoryShop() {
    var uuid = const Uuid();
    return [
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'Th???i trang',
          image: ImgAssets.icFashion),
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'Gia d???ng',
          image: ImgAssets.icWareHouse),
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'D???ng c??? h???c t???p',
          image: ImgAssets.icLeaningTool),
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'Thi???t b??? s???',
          image: ImgAssets.icTech),
      ShopCategory(
        idShopCategory: uuid.v1(),
        name: 'C??ng c???',
        image: ImgAssets.icTool,
      ),
    ];
  }

  static const String iduser1 = '1';
  static const String iduser2 = '2';
  static const String iduser3 = '3';
  static const String iduser4 = '4';
  static const String iduser5 = '5';

  static List<PostModel> getPost1(String idProduct) {
    var rng = Random();
    List<PostModel> posts1 = [
      PostModel(
          idPostModel: uuid.v1(),
          dateUp: DateTime.now(),
          idProduct: idProduct,
          idUser: iduser1,
          priceHight: rng.nextDouble() * 1000000,
          priceLow: rng.nextDouble() * 500000,
          status: true),
      PostModel(
          idPostModel: uuid.v1(),
          dateUp: DateTime.now(),
          idProduct: idProduct,
          idUser: iduser3,
          priceHight: rng.nextDouble() * 1000000,
          priceLow: rng.nextDouble() * 500000,
          status: true),
      PostModel(
          idPostModel: uuid.v1(),
          dateUp: DateTime.now(),
          idProduct: idProduct,
          idUser: iduser2,
          priceHight: rng.nextDouble() * 1000000,
          priceLow: rng.nextDouble() * 500000,
          status: true),
    ];
    List<PostModel> posts2 = [
      PostModel(
          dateUp: DateTime.now(),
          idPostModel: uuid.v1(),
          idProduct: idProduct,
          idUser: iduser4,
          priceHight: rng.nextDouble() * 1000000,
          priceLow: rng.nextDouble() * 500000,
          status: true),
      PostModel(
          idPostModel: uuid.v1(),
          dateUp: DateTime.now(),
          idProduct: idProduct,
          idUser: iduser5,
          priceHight: rng.nextDouble() * 1000000,
          priceLow: rng.nextDouble() * 500000,
          status: true),
    ];
    return rng.nextInt(2) == 2 ? posts1 : posts2;
  }
}
