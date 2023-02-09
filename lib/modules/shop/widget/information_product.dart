/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/model/shop/product_post.dart';
import 'package:student_app/modules/shop/widget/common_used/user_sell.dart';
import 'package:student_app/service/size_screen.dart';

import '../../../config/themes/app_text_styles.dart';
import '../../../widgets/stateful/list_img_info.dart';

class InformationProDuct extends StatelessWidget {
  double space = SizeScreen.sizeSpace;
  Color mainBackGound = Colors.white;
  final maginEdgeInsets = EdgeInsets.only(
      bottom: SizeScreen.sizeSpace / 2, top: SizeScreen.sizeSpace / 2);
  final paddingEdgeInsets =
      EdgeInsets.only(left: SizeScreen.sizeSpace, right: SizeScreen.sizeSpace);
  // ignore: prefer_const_constructors_in_immutables
  final ProductPost result;
  InformationProDuct({Key? key, required this.result}) : super(key: key);
  final maxLineDessctiption = 10;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: AppColors.backGround,
        child: Column(
          children: [
            ListImgInfo(
                URLImages: result.product!.imagesProduct!,
                URLImagesUser: result.post!.imgUser!),
            buildNameAndPrice(),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(SizeScreen.sizeSpace),
              child: const UserSell(
                name: 'Trần Ngọc Hoàng Long Hoàng Long',
              ),
            ),
            buildDescription(),
          ],
        ),
      ),
    );
  }

  Widget buildDescription() => Container(
        color: mainBackGound,
        padding: EdgeInsets.all(space),
        margin: maginEdgeInsets,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: maginEdgeInsets,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    StringApp.desscription,
                    style: TextStyle(
                        color: AppColors.orangeryYellow,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  result.product!.description!,
                  style: AppTextStyles.h5,
                  maxLines: maxLineDessctiption,
                ),
              ],
            )
          ],
        ),
      );

  Widget buildNameAndPrice() => Container(
        color: mainBackGound,
        margin: maginEdgeInsets,
        padding: paddingEdgeInsets,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                result.product!.nameProduct == null
                    ? 'Tên sản phẩm'
                    : result.product!.nameProduct!,
                style: AppTextStyles.h5,
                maxLines: 3,
              ),
            ),
            
            Container(
              margin: EdgeInsets.all(space / 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text(
                      StringApp.price,
                      textAlign: TextAlign.left,
                      style: AppTextStyles.priceTextStyleLarge,
                    ),
                    SizedBox(
                      height: SizeScreen.sizeSpace,
                      width: SizeScreen.sizeSpace,
                    ),
                    Text(
                      result.post!.ShowPrice(),
                      textAlign: TextAlign.left,
                      style: AppTextStyles.priceTextStyleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
