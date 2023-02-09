// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_app/constants/constant.dart';
import 'package:student_app/controller/category_controller.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/model/shop/product_post.dart';
import 'package:student_app/model/shop/shop_category.dart';
import 'package:student_app/modules/shop/screen/show_post_detail_page.dart';
import 'package:student_app/service/action/shop/shop_log_action.dart';
import 'package:student_app/widgets/stateless/loading.dart';
import 'package:student_app/widgets/stateless/no_result.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../widgets/stateless/image_found.dart';

import '../../../service/size_screen.dart';

class ItemPost extends StatelessWidget {
  final double widthSize;
  String imageLink;
  String name;
  String price;
  String idPostModel;
  double height;
  final VoidCallback clickAdd;
  final VoidCallback showDetail;
  ItemPost(
      {Key? key,
      required this.widthSize,
      this.imageLink = '',
      this.name = '',
      this.price = '',
      this.idPostModel = '',
      required this.height,
      required this.clickAdd,
      required this.showDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightSize = height;
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        width: widthSize,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.mainColor, width: 1),
            color: Colors.white),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            InkWell(
              onTap: showDetail,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    color: AppColors.backGround,
                    width: widthSize,
                    height: heightSize * 0.55,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: ImageNotFound(imageLink: imageLink)),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightSize * 0.20,
                  width: widthSize,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeScreen.sizeSpace,
                        right: SizeScreen.sizeSpace,
                        top: SizeScreen.sizeSpace),
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppTextStyles.h7,
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(
                  width: widthSize,
                  height: heightSize * 0.13,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeScreen.sizeSpace,
                      right: SizeScreen.sizeSpace,
                    ),
                    child: Text(
                      price,
                      overflow: TextOverflow.fade,
                      style: AppTextStyles.priceTextStyle,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: heightSize * 0.15,
                width: heightSize * 0.15,
                child: FloatingActionButton(
                  heroTag: idPostModel,
                  backgroundColor: AppColors.backGround,
                  onPressed: clickAdd,
                  child: const Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListItemPost extends StatefulWidget {
  final double widthSize;
  String idCategoryShop;
  bool isLoading;
  ListItemPost(
      {Key? key,
      required this.widthSize,
      required this.idCategoryShop,
      required this.isLoading})
      : super(key: key);
  @override
  State<ListItemPost> createState() => _ListItemPostState();
}

class _ListItemPostState extends State<ListItemPost> {
  List<ProductPost> result = [];
  final ScrollController _scrollController = ScrollController();
  List<ShopCategory> shopCategory = [];
  Future initDat() async {
    result =
        await ProductPostController().getProductPostNew(widget.idCategoryShop);
  }

  getData() {
    if (widget.isLoading) {
      initDat().whenComplete(() {
        Timer(const Duration(milliseconds: TIME_DELAY), () {
          setState(() {
            widget.isLoading = false;
          });
        });
      });
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //    _getMoreData();
      }
    });
  }

  Future _getMoreData() async {
    if (!ShopLogAction.mapLastProduct[widget.idCategoryShop]!) {
      result = await ProductPostController()
          .getMoreProductPost(widget.idCategoryShop);
      setState(() {});
    }
  }

  Future _getNew() async {
    result = await ProductPostController().getNew(widget.idCategoryShop);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double heightItem = (widget.widthSize / 2 - SizeScreen.sizeSpace) / 0.9;
    double widthItem = widget.widthSize / 2 - SizeScreen.sizeSpace;
    getData();
    return widget.isLoading
        ? SizedBox(width: widget.widthSize, child: const Loading())
        : result.isEmpty
            ? SizedBox(width: widget.widthSize, child: const NoResult())
            : SizedBox(
                width: widget.widthSize,
                child: RefreshIndicator(
                  onRefresh: _getNew,
                  child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              (widget.widthSize + SizeScreen.sizeSpace) / 2,
                          crossAxisSpacing: SizeScreen.sizeSpace / 2,
                          mainAxisSpacing: SizeScreen.sizeSpace / 2),
                      // 9 is reset it
                      itemCount: result.length ~/ 2 * heightItem <
                              SizeScreen.sizeHeightFull
                          ? SizeScreen.sizeHeightFull ~/ heightItem * 2 + 1
                          : result.length + 2,
                      itemBuilder: (BuildContext ctx, index) {
                        if (result.length <= index) {
                          return SizedBox(
                            width: widget.widthSize,
                            child: ShopLogAction
                                    .mapLastProduct[widget.idCategoryShop]!
                                ? Container()
                                : const Loading(),
                          );
                        }
                        return ItemPost(
                            height: heightItem,
                            widthSize: widthItem,
                            idPostModel: result[index].post!.idPostModel!,
                            imageLink: result[index].product!.imagesProduct![0],
                            name: result[index].product!.nameProduct!,
                            price: result[index].post!.ShowPrice(),
                            clickAdd: () {},
                            showDetail: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ShowPostDetailPage(
                                    idPost: result[index].post!.idPostModel!);
                              }));
                            });
                      }),
                ),
              );
  }
}
