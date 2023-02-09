import 'package:flutter/material.dart';
import 'package:student_app/controller/cart_controller.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/model/shop/pattern_product_model_buyer.dart';
import 'package:student_app/modules/shop/screen/shop_body_sheet.dart';
import 'package:student_app/service/action/shop/patten_product_acction.dart';
import 'package:student_app/service/action/shop/pattern_product_buyer_action.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';

import '../../../config/string/string_app.dart';
import '../../../config/themes/app_colors.dart';
import '../../../service/size_screen.dart';

// ignore: must_be_immutable
class AddCartNavigationBottom extends StatelessWidget {
  AddCartNavigationBottom({Key? key}) : super(key: key);
  double space = SizeScreen.sizeSpace;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeScreen.sizeWidthScreen,
      decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          border:
              Border(top: BorderSide(color: AppColors.mainColor, width: 2))),
      padding: EdgeInsets.all(space / 4),
      child: Row(children: [
        IconButtonRounded(
          spaceLeft: true,
          spaceRight: false,
          customWidget: SizedBox(
            height: SizeScreen.sizeSpace + SizeScreen.sizeIcon,
            width: SizeScreen.sizeSpace + SizeScreen.sizeIcon,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.more_horiz_outlined,
                    color: AppColors.mainColor,
                    size: SizeScreen.sizeIcon,
                  ),
                ]),
          ),
        ),
        SizedBox(
            height: SizeScreen.sizeIcon + SizeScreen.sizeSpace * 3,
            width: SizeScreen.sizeWidthScreen -
                (SizeScreen.sizeSpace + SizeScreen.sizeIcon) -
                SizeScreen.sizeSpace * 4,
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(right: space, left: space),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)))),
                  onPressed: () async {
                    PatternProductAction()
                        .getPatternProductFromFirebase(
                            ProductPostController.productPostSelected!.post!)
                        .whenComplete(() async {
                      CartController.patternProductModels.clear();
                      for (var element in PatternProductAction.pattenProducts) {
                        CartController.patternProductModels.add(
                          PatternProductModelBuyer(
                            pattenProductModel: element,
                            amountMax: element.amount!,
                          ),
                        );
                      }
                      CartController.patternProductModels[0].pattenProductModel
                          .amount = 1;
                      PatternProductModelBuyerAction
                              .patternProductModelBuyerSelected =
                          CartController.patternProductModels[0];
                    }).whenComplete(() {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return const ShopBodySheet();
                        },
                      );
                    });
                  },
                  child: const Text(
                    StringApp.addToCart,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ))
      ]),
    );
  }
}
