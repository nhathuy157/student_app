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
        nameProduct: 'Áo Thời Trang SaG chất liệu cotton 100%',
        description: '''Áo thời trang sản phẩm mới Sa.G
Áo in lụa . chất vãi cotton 100% , có giãn tốt , 
Có 3 size M L XL
Áo form chuẩn . chất liệu vãi co giãn , 
Thời trang , đơn giãn nhưng sản phẩm áo cực kì tốt ''',
        numberPosts: 2,
      ),

      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct:
            'Amazing, thời trang công sở cao cấp, áo sơ mi nam form chuẩn, thân suông, vạt bầu, tay dài, nhiều màu, nhiều size',
        description: '''
1. Thông tin sản phẩm :
1. Thông tin sản phẩm :
 - chất liệu : cotton dày dặn thấm hút mồ hôi
 - màu sắc áo thun nam UNICI có : Đen - Trắng
 - áo thun nam UNICI mềm mại mặc thoải mái phù hợp cho cả việc đi chơi và làm việc nhé các bạn 
 - Đường may tinh tế, tỉ mỉ trong từng chi tiết đã làm lên thương hiệu của thời trang UNICI 
 - Form suông mang lại sự thoải mái trước và sau đều in hình unisex
 - Chất lượng sản phẩm tốt, giá cả hợp lý

2. Hướng dẫn chọn size: (Bảng size Áo Thun Nam Cao Cấp UNICI chỉ mang tính chất tham khảo, nếu bạn không chắc chắn về size của mình, hãy nhắn tin để shop hỗ trợ bạn nha)
 - Size M: cân nặng <50kg, chiều cao: <1m55 
 - Size L: cân nặng: <60kg, Chiều cao: <1m65 
 - Size XL : cân nặng: <70kg, chiều cao: <1m72        
 - Size XXL: cân nặng: <75kg, chiều cao: <1m80 
 
3. Hướng dẫn ĐẶT HÀNG được FREESHIP 
 -  Nếu các bạn mua 1 sản phẩm, vui lòng ấn mua ngay 
 -  Nếu các bạn mua từ 2 sản phẩm trở lên, vui lòng ấn thêm vào giỏ hàng, và lần lượt thêm các sản phẩm bạn muốn mua vào giỏ trước khi đặt hàng và thanh toán. Các bạn nên tận dụng mã giảm giá vận chuyển của shopee bằng cách đặt đơn hàng trên 150k nếu bạn ở Hà Nội, trên 250k ở các tỉnh thành còn lại nhé, điều này sẽ giúp mình tiết kiệm được kha khá tiền đó ạ.''',
        numberPosts: 23,
      ),

      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct:
            'Quần tây âu cao cấp, thời trang công sở không ly, form dáng chuẩn, họa tiết vân chìm, có size đại',
        description:
            '''IẾN TẠO VẺ NGOÀI HOÀN HẢO VỚI THỜI TRANG CÔNG SỞ CAO CẤP AMAZING
- Quần tây âu Amazing, được sản xuất trên dây chuyền công nghệ cao, tỉ mỉ từng đường kim, mũi chỉ, sắc sảo như may đo.
- Màu đen và xanh đen navy, là dạng quần căn bản không bao giờ lỗi mốt, size số đầy đủ từ 45kg đến 100kg, già trẻ, lớn bé, cao thấp, mập ốm gì cũng mặc được. 
- Thiết kế quần không ly, form dáng truyền thống chuẩn mực, là iterm thanh lịch được sử dụng hằng ngày của các chàng công sở văn phòng, hay các event, dạo chơi..
- Vải nhập khẩu trực tiếp từ Ấn Độ, chất liệu T/R/S (70% Tetron - 28% Rayon - 2% Spandex)
- Quần chưa lên lai, Quý khách vui lòng “đo ni đóng giày” cho chiếc quần tròn 10 điểm hoàn hảo nhé! Các anh quá cao hay hơi thấp một chút cũng yên tâm khi mua quần này nhé.
- HƯỚNG DẪN CHỌN SIZE:
Để dễ dàng chọn được chiếc quần tây nam vừa vặn với mình bạn nên biết vòng eo (vị trí lưng quần mà bạn thường mặc).
 Vd: vòng eo của bạn là 80cm, thêm 2cm cử động, bạn nên chọn size 31. 
Chỉ số cân nặng dưới đây chỉ mang tính tham khảo, để bạn biết cái khoảng size phù hợp với mình.
Size	Cân nặng  Vòng eo quần thành phẩm                                 ''',
        numberPosts: 2,
      ),
      ProductSellModel(
        idShopCategory: stringIdCategory,
        idProduct: uuid.v1(),
        nameProduct: 'kính nữ thời trang',
        description: '''️ Đen ( kính có tròng )

️ Bác nào cận mua về lắp cận cũng ngon lành cành đào đó ạ

Giá sản phẩm trên Tiki đã bao gồm thuế theo luật hiện hành. Bên cạnh đó, tuỳ vào loại sản phẩm, hình thức và địa chỉ giao hàng mà có thể phát sinh thêm chi phí khác như phí vận chuyển, phụ phí hàng cồng kềnh, thuế nhập khẩu (đối với đơn hàng giao từ nước ngoài có giá trị trên 1 triệu đồng).....

Sản phẩm này là tài sản cá nhân được bán bởi Nhà Bán Hàng Cá Nhân và không thuộc đối tượng phải chịu thuế GTGT. Do đó hoá đơn VAT không được cung cấp trong trường hợp này.''',
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
          name: 'Thời trang',
          image: ImgAssets.icFashion),
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'Gia dụng',
          image: ImgAssets.icWareHouse),
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'Dụng cụ học tập',
          image: ImgAssets.icLeaningTool),
      ShopCategory(
          idShopCategory: uuid.v1(),
          name: 'Thiết bị số',
          image: ImgAssets.icTech),
      ShopCategory(
        idShopCategory: uuid.v1(),
        name: 'Công cụ',
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
