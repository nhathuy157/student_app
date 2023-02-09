import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/shop/pattern_product_model_buyer.dart';
import 'package:student_app/modules/shop/widget/common_used/grid_view_custom.dart';
import 'package:student_app/service/action/shop/pattern_product_buyer_action.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:student_app/widgets/stateless/image_found.dart';

class TypeSample extends StatefulWidget {
  final Function() notifyParent;
  final List<PatternProductModelBuyer> pattenProductModelsBuyer;
  const TypeSample(
      {Key? key,
      required this.pattenProductModelsBuyer,
      required this.notifyParent})
      : super(key: key);

  @override
  State<TypeSample> createState() => _TypeSampleState();
}

class _TypeSampleState extends State<TypeSample> {
  List<PatternProductModelBuyer> patterProductModelsBuyer = [];
  @override
  void initState() {
    super.initState();
    patterProductModelsBuyer = widget.pattenProductModelsBuyer;
  }

  int indexSelected = 0;
  Widget typeSampleItem(
      String text, String imgLink, int index, VoidCallback onTap) {
    return SizedBox(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  // color: changeColor ? AppColors.mainColor : Colors.white,
                  border: indexSelected == index
                      ? Border.all(
                          width: 1,
                          color: AppColors.mainColor,
                        )
                      : Border.all(width: 0),
                  color: indexSelected == index ? Colors.white : AppColors.grey,
                ),
                child: IntrinsicWidth(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeScreen.sizeSpace,
                      vertical: SizeScreen.sizeSpace,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyBlur,
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: SizedBox.fromSize(
                                child: ImageNotFound(
                                  imageLink: imgLink,
                                  boxFit: BoxFit.fill,
                                  heightImage: SizeScreen.sizeIcon,
                                  widthImage: SizeScreen.sizeIcon,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: SizeScreen.sizeSpace),
                            child: Text(
                              text,
                              style: AppTextStyles.h5,
                            ),
                          ),
                          flex: 11,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            indexSelected == index
                ? Positioned(
                    left: -SizeScreen.sizeSpace,
                    top: -SizeScreen.sizeSpace - 1,
                    child: SvgPicture.asset(
                      ImgAssets.icTickerTriangle,
                      width: SizeScreen.sizeBox,
                      height: SizeScreen.sizeBox,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int numberOfHeight = patterProductModelsBuyer.length % 2 == 0
        ? patterProductModelsBuyer.length
        : patterProductModelsBuyer.length + 1;
    return patterProductModelsBuyer.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: SizeScreen.sizeSpace),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Loại mẫu',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.greyBlur,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: patterProductModelsBuyer.length <= 6
                    ? (SizeScreen.sizeBox + SizeScreen.sizeSpace) *
                        numberOfHeight /
                        2
                    : (SizeScreen.sizeBox + SizeScreen.sizeSpace) * 6 / 2,
                width: SizeScreen.sizeWidthScreen,
                child: GridView.builder(
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            height: SizeScreen.sizeBox),
                    itemCount: patterProductModelsBuyer.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return typeSampleItem(
                          patterProductModelsBuyer[index]
                              .pattenProductModel
                              .namePattern!,
                          patterProductModelsBuyer[index]
                              .pattenProductModel
                              .imageLink!,
                          index, () {
                        setState(
                          () {
                            indexSelected = index;
                            PatternProductModelBuyerAction
                                    .patternProductModelBuyerSelected =
                                patterProductModelsBuyer[index];
                            PatternProductModelBuyerAction
                                .patternProductModelBuyerSelected
                                .pattenProductModel
                                .amount = 1;
                            // CartController.amountMax = PatternProductAction()
                            //     .findAmountMaxPatternOrigin(PatternProductAction
                            //         .patternProductSelected);
                            // devtools.log("amount max la:" +
                            //     CartController.amountMax.toString());
                            // PatternProductAction.patternProductSelected.amount =
                            //     1;
                            widget.notifyParent();
                          },
                        );
                      });
                    }),
              )
            ],
          );
  }
}
