import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_app/controller/category_controller.dart';
import 'package:student_app/controller/product_post_controller.dart';

import '../../../config/string/string_app.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../constants/assets_part.dart';
import '../../../model/shop/shop_category.dart';
import '../../../service/action/shop/shop_category.dart';
import '../../../service/other/user_action.dart';
import '../../../service/size_screen.dart';

// ignore: must_be_immutable
class ItemCategoryShop extends StatefulWidget {
  final String ic;
  final String nameCategory;
  final VoidCallback onClick;
  final double sizeWidth;
  final double sizeHeight;
  bool isSelect;
  bool showBorder;
  ItemCategoryShop(
      {Key? key,
      required this.ic,
      required this.nameCategory,
      this.showBorder = false,
      required this.onClick,
      required this.sizeWidth,
      required this.sizeHeight,
      this.isSelect = false})
      : super(key: key);

  @override
  State<ItemCategoryShop> createState() => _ItemCategoryShopState();
}

class _ItemCategoryShopState extends State<ItemCategoryShop> {
  late Color mainColor;
  late Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    if (widget.isSelect) {
      mainColor = AppColors.mainColor;
      backGroundColor = Colors.white;
    } else {
      mainColor = AppColors.greyBlur;
      backGroundColor = AppColors.backGround;
    }
    return Stack(
      children: [
        InkWell(
          onTap: widget.onClick,
          child: Container(
            decoration: BoxDecoration(
                color: backGroundColor,
                border: widget.showBorder
                    ? Border.all(color: AppColors.mainColor)
                    : null),
            padding: const EdgeInsets.all(2),
            height: widget.sizeHeight,
            width: widget.sizeWidth,
            child: SizedBox(
              height: widget.sizeHeight,
              width: widget.sizeWidth,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(SizeScreen.sizeSpace),
                  child: SizedBox(
                    height: SizeScreen.sizeBox - SizeScreen.sizeSpace,
                    width: SizeScreen.sizeBox - SizeScreen.sizeSpace,
                    child: SvgPicture.asset(widget.ic, color: mainColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeScreen.sizeSpace / 3,
                      right: SizeScreen.sizeSpace / 3),
                  child: Text(
                    widget.nameCategory,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 7,
                      color: mainColor,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
            ),
          ),
        ),
        widget.isSelect
            ? Positioned(
                right: 0 - SizeScreen.sizeSpace,
                top: widget.sizeHeight / 2 - SizeScreen.sizeSpace,
                child: Icon(
                  Icons.arrow_left,
                  size: SizeScreen.sizeIcon,
                  color: mainColor,
                ))
            : Container(),
      ],
    );
  }
}

// ignore: must_be_immutable
class ListCategoryShop extends StatefulWidget {
  ListCategoryShop({Key? key, required this.productPost}) : super(key: key);
  ProductPostController productPost;

  @override
  State<ListCategoryShop> createState() => _ListCategoryShopState();
}

class _ListCategoryShopState extends State<ListCategoryShop> {
  List<ShopCategory> categories = CategoryController.shopCategories;

  double sizeWidthCategory = SizeScreen.sizeWidthCategory;

  double percentHeight = 0.8;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: SizeScreen.sizeHeightScreen,
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Column(
          children: [
            SizedBox(
              width: sizeWidthCategory,
              height: SizeScreen.sizeHeightScreen -
                  sizeWidthCategory / percentHeight -
                  SizeScreen.sizeSpace,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: SizeScreen.sizeSpace / 8,
                          bottom: SizeScreen.sizeSpace / 8),
                      child: ItemCategoryShop(
                        sizeHeight: sizeWidthCategory / percentHeight,
                        ic: categories[index].image!,
                        nameCategory: categories[index].name!,
                        isSelect: widget.productPost.idShopCategory ==
                            categories[index].idShopCategory,
                        onClick: () {
                          setState(() {
                            if (widget.productPost.idShopCategory !=
                                categories[index].idShopCategory) {
                              widget.productPost.idShopCategory =
                                  categories[index].idShopCategory!;
                            }
                          });
                        },
                        sizeWidth: sizeWidthCategory,
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: SizeScreen.sizeSpace / 2,
                  top: SizeScreen.sizeSpace / 2),
              child: ItemCategoryShop(
                ic: ImgAssets.icUser,
                sizeHeight: sizeWidthCategory / percentHeight,
                nameCategory: StringApp.users,
                showBorder: true,
                onClick: () {},
                sizeWidth: sizeWidthCategory,
              ),
            )
          ],
        ),
      ),
    );
  }
}
