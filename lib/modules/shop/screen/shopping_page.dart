import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_app/constants/constant.dart';
import 'package:student_app/controller/category_controller.dart';
import 'package:student_app/controller/product_post_controller.dart';

import 'package:student_app/widgets/stateless/icon_inside.dart';
import 'package:student_app/widgets/stateless/loading.dart';
import 'package:provider/provider.dart';

import '../../../config/themes/app_colors.dart';
import '../../../service/action/shop/shop_category.dart';
import '../../../service/size_screen.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../widget/icon_button_cart.dart';
import '../widget/item_post.dart';
import '../widget/item_shop_category.dart';
import '../../../widgets/stateless/search_widget.dart';

class ShoppingPage extends StatefulWidget {
  ShoppingPage({Key? key}) : super(key: key);
  final double sizeWidthCategory =
      SizeScreen.sizeWidthCategory + SizeScreen.sizeSpace;

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  bool loading = true;

  Future _getThingsOnStartup() async {
    await CategoryController().getShopCategory();
  }

  @override
  void initState() {
    _getThingsOnStartup().whenComplete(() {
      Timer(const Duration(microseconds: TIME_DELAY), () {
        setState(() {
          loading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double sizeWidthPosts = SizeScreen.sizeWidthScreen -
        widget.sizeWidthCategory -
        SizeScreen.sizeSpace * 2;
    return SafeArea(
      child: loading
          ? const Loading()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.lightGreen,
                titleSpacing: 0,
                leading: IconButtonBack(),
                actions: [
                  SearchWidget(numberIcon: 3, onTap: () {}),
                  IconButtonRounded(
                      customWidget: IconInside(
                    iconCustom: const Icon(Icons.filter_alt_outlined),
                    onClick: () {},
                  )),
                  IconButtonCart(),
                ],
              ),
              body: Consumer<ProductPostController>(
                builder: (context, productPost, child) {
                  return Container(
                    color: AppColors.backGround,
                    child: Row(
                      children: [
                        ListCategoryShop(productPost: productPost),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(SizeScreen.sizeSpace),
                            child: ListItemPost(
                                widthSize: sizeWidthPosts,
                                idCategoryShop: productPost.idShopCategory,
                                isLoading: productPost.isLoading),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
