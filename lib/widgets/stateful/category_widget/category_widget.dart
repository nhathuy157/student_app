import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/controller/utility.dart';
import 'package:student_app/model/other/category.dart';
import 'package:student_app/widgets/stateful/category_widget/category_show_all_page.dart';
import 'package:student_app/widgets/stateful/category_widget/item_category_widget.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controller/category_controller.dart';
import '../../../model/other/location_category.dart';

import '../../../service/size_screen.dart';

enum TypeShow {
  non,
  showMore,
  showAll,
  showImg,
}

class CategoryWidget extends StatefulWidget {
  List<String> itemsSelected;
  List<Category> categories;
  int numberColum;
  int numberRow;
  String nameCategory;
  bool newPage;
  bool center;
  TypeShow typeShow;
  CategoryWidget(
      {Key? key,
      this.numberRow = 3,
      this.numberColum = 3,
      required this.itemsSelected,
      required this.categories,
      required this.nameCategory,
      this.center = false,
      this.newPage = false,
      this.typeShow = TypeShow.non})
      : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool changeColor = false;
  String text = "";
  bool isShowMore = false;
  double mainAxisExtent = 0;
  int crossAxisCount = 0;
  double crossAxisSpacing = 12;
  double mainAxisSpacing = 12;
  int mainAxisCount = 3;
  double sizeDefault = 0;
  double sizeMax = 0;
  double _heightContainerLocation = 0;
  late double getSizeMin;
  double heightTitle = SizeScreen.sizeIcon;
  String numberSelected = "";

  changeTextLocation() {
    if (isShowMore) {
      _heightContainerLocation = sizeDefault;
      text = StringApp.showMore;
    } else {
      _heightContainerLocation = sizeMax;
      text = StringApp.hideLess;
    }
    isShowMore = !isShowMore;
    setState(() {});
  }

  initTextBottom() {
    switch (widget.typeShow) {
      case TypeShow.showMore:
        text = StringApp.showMore;
        break;
      case TypeShow.showAll:
        text = StringApp.showAll;
        break;
      default:
        text = "";
        break;
    }
  }

  Future newPageCategory() async {
    sortCategory();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryShowAllPage(
          categorySelected: widget.itemsSelected,
          categories: categories,
        ),
      ),
    );
    sortCategory();
    setState(() {});
  }

  double heightAll() {
    switch (widget.typeShow) {
      case TypeShow.non:
      case TypeShow.showImg:
        return _heightContainerLocation +
            heightTitle +
            mainAxisSpacing +
            SizeScreen.sizeSpace * 2;
      case TypeShow.showAll:
      case TypeShow.showMore:
        return _heightContainerLocation +
            heightTitle * 2 +
            SizeScreen.sizeSpace * 2 +
            mainAxisSpacing;
    }
  }

  double heightInside() {
    switch (widget.typeShow) {
      case TypeShow.non:
      case TypeShow.showImg:
        return _heightContainerLocation +
            SizeScreen.sizeSpace +
            mainAxisSpacing;
      case TypeShow.showAll:
      case TypeShow.showMore:
        return _heightContainerLocation +
            heightTitle +
            SizeScreen.sizeSpace +
            mainAxisSpacing;
    }
  }

  sortCategory() {
    switch (widget.typeShow) {
      case TypeShow.showAll:
      case TypeShow.showMore:
        categories = sortCategorySelect(
            categories: categories, selected: widget.itemsSelected);
        break;
      default:
        break;
    }
  }

  initSize() {
    switch (widget.typeShow) {
      case TypeShow.showImg:
        mainAxisExtent = (SizeScreen.sizeWidthScreen -
                (widget.numberColum + 1) * crossAxisSpacing) /
            widget.numberColum;
        break;
      default:
        mainAxisExtent = 36;
        break;
    }
    sizeDefault =
        mainAxisCount * mainAxisExtent + (mainAxisCount) * mainAxisSpacing;
    int countAxisMainMax = categories.length ~/ crossAxisCount +
        (categories.length % crossAxisCount > 0 ? 1 : 0);
    sizeMax = countAxisMainMax * mainAxisExtent +
        (countAxisMainMax) * mainAxisSpacing;
    _heightContainerLocation = sizeDefault;
  }

  List<Category> categories = [];
  @override
  void initState() {
    categories = widget.categories;
    crossAxisCount = widget.numberColum;
    mainAxisCount = widget.numberRow;
    sortCategory();
    initTextBottom();
    initSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(top: mainAxisSpacing / 2),
      duration: Duration(milliseconds: 400),
      height: heightAll(),
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(right: mainAxisSpacing, left: mainAxisSpacing),
            height: heightTitle,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.nameCategory +
                      " " +
                      getNumberSelected(widget.itemsSelected),
                  style: AppTextStyles.h4.copyWith(
                      fontSize: 18,
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.w600),
                ),
                widget.itemsSelected.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          widget.itemsSelected.clear();
                          setState(() {});
                        },
                        child: const Text(
                          StringApp.clear,
                          style: TextStyle(
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          AnimatedContainer(
              padding: EdgeInsets.only(
                  top: mainAxisSpacing,
                  right: mainAxisSpacing,
                  left: mainAxisSpacing),
              duration: Duration(milliseconds: 400),
              height: heightInside(),
              decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 6),
                        blurRadius: 6)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    height: _heightContainerLocation,
                    child: GridView.builder(
                      physics: isShowMore
                          ? const NeverScrollableScrollPhysics()
                          : const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisExtent: mainAxisExtent,
                        mainAxisSpacing: mainAxisSpacing,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ItemCategoryWidget(
                          sizeItem: mainAxisExtent,
                          center: widget.center,
                          onTab: () {
                            setState(() {
                              if (widget.itemsSelected
                                  .contains(categories[index].id)) {
                                widget.itemsSelected
                                    .remove(categories[index].id);
                              } else {
                                widget.itemsSelected.add(categories[index].id);
                              }
                            });
                          },
                          name: categories[index].name,
                          changeColor: widget.itemsSelected
                              .contains(categories[index].id),
                          selectedLocation: widget.itemsSelected,
                          img: categories[index].img,
                        );
                      },
                    ),
                  ),
                  showBottomWidget(),
                ],
              )),
        ],
      ),
    );
  }

  Widget showBottomWidget() {
    switch (widget.typeShow) {
      case TypeShow.non:
      case TypeShow.showImg:
        return Container();
      case TypeShow.showMore:
      case TypeShow.showAll:
        return Container(
          margin: EdgeInsets.all(SizeScreen.sizeSpace / 4),
          height: heightTitle,
          child: InkWell(
            onTap: (() async {
              switch (widget.typeShow) {
                case TypeShow.showAll:
                  await newPageCategory();
                  break;
                case TypeShow.showMore:
                  changeTextLocation();
                  break;
                default:
                  break;
              }
            }),
            child: Text(
              text,
              style: AppTextStyles.h4,
            ),
          ),
        );
    }
  }
}
