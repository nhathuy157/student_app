// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';

import '../../config/themes/app_colors.dart';
import '../../service/size_screen.dart';
import '../stateless/image_found.dart';

class ListImgInfo extends StatefulWidget {
  const ListImgInfo({Key? key, required this.URLImages, this.URLImagesUser})
      : super(key: key);
  final List<String> URLImages;
  final List<String>? URLImagesUser;
  @override
  State<ListImgInfo> createState() => _ListImgInfoState();
}

class _ListImgInfoState extends State<ListImgInfo> {
  final double _widthSize = SizeScreen.sizeWidthScreen;
  final double _heightSize = SizeScreen.sizeWidthScreen / 4 * 3;
  final _imgCircular = 26.0;
  int _lengthUser = 0;
  int _activeIndex = 0;
  double space = SizeScreen.sizeSpace;
  final double _sizeHeight = SizeScreen.sizeSpace * 3;
  int _lengthImg = 0;
  final TextStyle _textStyle = const TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.white);
  List<String> images = [];
  void _getImg() {
    images.addAll(widget.URLImages);
    if (widget.URLImagesUser != null) {
      images.addAll(widget.URLImagesUser!);
      _lengthUser = widget.URLImages.length;
    }
    _lengthImg = images.length;
  }

  @override
  void initState() {
    _getImg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deltaFontSize = ((_lengthImg.toString()).length - 1) * 2.0;
    return Stack(
      children: [
        Container(
          height: _heightSize,
          width: _widthSize,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(_imgCircular),
                  bottomLeft: Radius.circular(_imgCircular))),
          child: _lengthImg == 0
              ? buildImage("", 0)
              : CarouselSlider.builder(
                  itemCount: _lengthImg,
                  options: CarouselOptions(
                      height: _heightSize,
                      reverse: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _activeIndex = index;
                        });
                      }),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = images[index];
                    return buildImage(urlImage, index);
                  },
                ),
        ),
        widget.URLImages.isEmpty
            ? Container()
            : Positioned(
                bottom: space,
                right: space,
                child: buildIndexImage(deltaFontSize),
              ),
        Positioned(left: space, bottom: space, child: buildProviderAndReport())
      ],
    );
  }

  Widget buildProviderAndReport() => Row(
        children: [
          buildReport(),
          _activeIndex > (_lengthImg - _lengthUser - 1) && (_lengthImg > 0)
              ? Container(
                  padding: EdgeInsets.only(left: space / 2, right: space / 2),
                  height: _sizeHeight,
                  decoration: const BoxDecoration(
                      color: AppColors.greyBlur,
                      // border: Border.all(width: 1, color: AppColors.mainColor),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Center(
                    child: Text(StringApp.providedBySeller, style: _textStyle),
                  ))
              : Container(),
        ],
      );
  Widget buildImage(String urlImage, int index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: AppColors.backGround,
      child: ImageNotFound(
        imageLink: urlImage,
      ));
  Widget buildIndexImage(double deltaFontSize) => Container(
        width: SizeScreen.sizeSpace * 6,
        height: SizeScreen.sizeSpace * 3,
        decoration: const BoxDecoration(
            color: AppColors.greyBlur,
            // border: Border.all(width: 1, color: AppColors.mainColor),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
            child: AutoSizeText(
          '${_activeIndex + 1}/$_lengthImg',
          style: TextStyle(
              fontSize: 12.0 - deltaFontSize,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        )),
      );
  Widget buildReport() => InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(right: space),
          padding: EdgeInsets.only(left: space / 2, right: space / 2),
          height: _sizeHeight,
          width: _sizeHeight,
          decoration: const BoxDecoration(
              color: AppColors.greyBlur,
              // border: Border.all(width: 1, color: AppColors.mainColor),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: const Center(
              child: Icon(
            Icons.flag,
            color: Colors.white,
            size: 12,
          )),
        ),
      );
}
