import 'package:flutter/material.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/model/shop/product_post.dart';

import '../../../service/size_screen.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../widget/add_cart_navigation_bottom.dart';
import '../widget/icon_button_cart.dart';
import '../widget/information_product.dart';

class ShowPostDetailPage extends StatefulWidget {
  final String idPost;
  const ShowPostDetailPage({Key? key, required this.idPost}) : super(key: key);

  @override
  State<ShowPostDetailPage> createState() => _ShowPostDetailPageState();
}

class _ShowPostDetailPageState extends State<ShowPostDetailPage> {
  late ProductPost resultProduct;
  @override
  void initState() {
    resultProduct = ProductPostController().getById(widget.idPost);
    ProductPostController.productPostSelected = resultProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: SizeScreen.sizeWidthScreen,
              height: SizeScreen.sizeHeightFull -
                  SizeScreen.sizeBox -
                  SizeScreen.sizeSpace * 2,
              child: SingleChildScrollView(
                  child: InformationProDuct(
                result: resultProduct,
              )),
            ),
          ),
          Positioned(
              top: SizeScreen.sizeSpace,
              left: SizeScreen.sizeSpace,
              child: IconButtonBack(showDecoration: true)),
          Positioned(
              top: SizeScreen.sizeSpace,
              right: SizeScreen.sizeSpace,
              child: IconButtonCart()),
          Positioned(bottom: 0, child: AddCartNavigationBottom()),
        ]),
      ),
    );
  }
}
