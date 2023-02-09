import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/controller/cart_controller.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/modules/shop/screen/cart_page.dart';
import 'package:student_app/modules/shop/widget/common_used/item_product.dart';
import 'package:student_app/modules/shop/widget/common_used/type_sample.dart';
import 'package:student_app/service/action/shop/pattern_product_buyer_action.dart';
import 'package:student_app/service/size_screen.dart';

class ShopBodySheet extends StatefulWidget {
  const ShopBodySheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopBodySheet> createState() => _ShopBodySheetState();
}

class _ShopBodySheetState extends State<ShopBodySheet> {
  refresh() {
    setState(() {});
  }

  bool checkPatternsInCartContainSelected() {
    for (var element in CartController.patternProductModelsCart) {
      if (element.pattenProductModel.idPattenProduct ==
          PatternProductModelBuyerAction.patternProductModelBuyerSelected
              .pattenProductModel.idPattenProduct) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.only(
              top: SizeScreen.sizeSpace / 2,
              left: SizeScreen.sizeSpace,
            ),
            child: ItemPatternProduct(
              patternProductModelBuyer: PatternProductModelBuyerAction
                  .patternProductModelBuyerSelected,
              crossAxisAlignment: CrossAxisAlignment.start,
              productPost: ProductPostController.productPostSelected!,
              isSetAmountEqual1: true,
              //nut thoat
              widthImage: SizeScreen.sizeBox * 3,
              onChange: (int val) {
                if (val < 1) {
                  setState(() {
                    PatternProductModelBuyerAction
                        .patternProductModelBuyerSelected
                        .pattenProductModel
                        .amount = 1;
                  });
                } else if (val >= 1 &&
                    val <
                        PatternProductModelBuyerAction
                            .patternProductModelBuyerSelected.amountMax) {
                  setState(() {
                    PatternProductModelBuyerAction
                        .patternProductModelBuyerSelected
                        .pattenProductModel
                        .amount = val;
                  });
                } else if (val >=
                    PatternProductModelBuyerAction
                        .patternProductModelBuyerSelected.amountMax) {
                  setState(() {
                    PatternProductModelBuyerAction
                            .patternProductModelBuyerSelected
                            .pattenProductModel
                            .amount =
                        PatternProductModelBuyerAction
                            .patternProductModelBuyerSelected.amountMax;
                  });
                } else {
                  setState(() {
                    PatternProductModelBuyerAction
                        .patternProductModelBuyerSelected
                        .pattenProductModel
                        .amount = 0;
                  });
                }
              },
              heightImage: SizeScreen.sizeBox * 3.5,
              widgetExtend: MaterialButton(
                padding: EdgeInsets.all(SizeScreen.sizeSpace / 1.5),
                minWidth: 0,
                height: 0,
                elevation: 4.0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: AppColors.mainColor,
                // fillColor: AppColors.mainColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close_outlined,
                  size: SizeScreen.sizeIcon,
                  color: Colors.white,
                ),
                shape: const CircleBorder(),
              ),
            )),
        const Divider(
          color: AppColors.grey,
          thickness: 2,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeScreen.sizeSpace),
            child: TypeSample(
              notifyParent: refresh,
              pattenProductModelsBuyer: CartController.patternProductModels,
            )),
        const Divider(
          color: AppColors.grey,
          thickness: 2,
        ),
        Container(
          height: SizeScreen.sizeBox + SizeScreen.sizeSpace * 3,
          width: SizeScreen.sizeWidthScreen,
          padding: EdgeInsets.only(
              left: SizeScreen.sizeSpace * 1.5,
              right: SizeScreen.sizeSpace * 1.5,
              bottom: SizeScreen.sizeSpace),
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
            onPressed: () {
              // devtools.log("thang dang chon" +
              //     PatternProductAction.patternProductSelected.amount
              //     .toString());
              setState(() {
                if (CartController.patternProductModelsCart.isEmpty) {
                  CartController.patternProductModelsCart.add(
                      PatternProductModelBuyerAction
                          .patternProductModelBuyerSelected);
                } else {
                  // CartController.patternProductModelsCart
                  //         .contains(PatternProductAction.patternProductSelected)
                  // CartController.patternProductModelsCart.contains(value)
                  checkPatternsInCartContainSelected()
                      ? CartController.patternProductModelsCart
                      : CartController.patternProductModelsCart.add(
                          PatternProductModelBuyerAction
                              .patternProductModelBuyerSelected);
                }
                // CartController.patternProductModelsCart
                //     .add(PatternProductAction.patternProductSelected);
              });
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  curve: Curves.bounceOut,
                  duration: const Duration(microseconds: 400),
                  child: const CartPage(),
                ),
              );
            },
            child: const Text(
              StringApp.addToCartProduct,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
