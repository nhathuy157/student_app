import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/controller/utility.dart';
import 'package:student_app/model/shop/pattern_product_model_buyer.dart';
import 'package:student_app/model/shop/product_post.dart';
import 'package:student_app/modules/shop/widget/common_used/counter_mount_product.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:student_app/widgets/stateless/image_found.dart';

class ItemPatternProduct extends StatefulWidget {
  final ProductPost productPost;
  final PatternProductModelBuyer patternProductModelBuyer;
  double widthImage;
  bool listenTotalMoneyChange;
  double heightImage;
  int maxLineNamePattern;
  ValueChanged<int> onChange;
  CrossAxisAlignment crossAxisAlignment;
  bool isSetAmountEqual1;
  Widget widgetExtend;
  ItemPatternProduct(
      {Key? key,
      required this.productPost,
      required this.patternProductModelBuyer,
      this.widgetExtend = const SizedBox(),
      required this.widthImage,
      this.isSetAmountEqual1 = false,
      this.maxLineNamePattern = 2,
      this.listenTotalMoneyChange = false,
      required this.onChange,
      required this.heightImage,
      required this.crossAxisAlignment})
      : super(key: key);

  @override
  State<ItemPatternProduct> createState() => _ItemPatternProductState();
}

class _ItemPatternProductState extends State<ItemPatternProduct> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeScreen.sizeSpace / 2),
      child: Row(
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          ///==========hinh anh
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(right: SizeScreen.sizeSpace),
              child: Container(
                padding: const EdgeInsets.all(1),
                width: widget.widthImage,
                height: widget.heightImage,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: SizedBox.fromSize(
                    // size: const Size.fromRadius(16),
                    child: ImageNotFound(
                      widthImage: widget.widthImage,
                      heightImage: widget.heightImage,
                      imageLink: widget.productPost.post!.imgUser![0],
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
                // width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          //==========/ ten gia san pham
          Flexible(
            fit: FlexFit.tight,
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.productPost.product!.nameProduct == null
                        ? 'Tên sản phẩm'
                        : widget.productPost.product!.nameProduct!,
                    style: AppTextStyles.h4,
                    maxLines: widget.maxLineNamePattern,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: widget.patternProductModelBuyer.pattenProductModel
                          .namePattern!.isEmpty
                      ? const SizedBox()
                      : Text(
                          '(' +
                              widget.patternProductModelBuyer.pattenProductModel
                                  .namePattern! +
                              ')',
                          style: AppTextStyles.h45
                              .copyWith(color: AppColors.greyBlur),
                        ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    priceToVND(
                      widget.patternProductModelBuyer.pattenProductModel.price!,
                    ),
                    style: AppTextStyles.h4.copyWith(
                        fontWeight: FontWeight.bold, color: AppColors.redPrice),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CounterMountProduct(
                    count: widget
                        .patternProductModelBuyer.pattenProductModel.amount!,
                    onChange: widget.onChange,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(children: [
                    Icon(
                      Icons.warning,
                      color: AppColors.orangeryYellow,
                      size: SizeScreen.sizeIcon * 2 / 3,
                    ),
                    SizedBox(
                      width: SizeScreen.sizeSpace,
                    ),
                    Text(
                      'Số lượng bán: ',
                      style: AppTextStyles.h45
                          .copyWith(color: AppColors.mainColor),
                    ),
                    Text(
                      widget.patternProductModelBuyer.amountMax.toString(),
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.redPrice,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: widget.widgetExtend,
          )
        ],
      ),
    );
  }
}
