import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/controller/cart_controller.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/model/shop/pattern_product_model_buyer.dart';
import 'package:student_app/model/shop/product_post.dart';
import 'package:student_app/modules/shop/widget/common_used/item_product.dart';
import 'package:student_app/modules/shop/widget/common_used/user_sell.dart';
import 'package:student_app/modules/shop/widget/in_cart_page/bottom_stack.dart';
import 'package:student_app/service/size_screen.dart';
import 'dart:developer' as devtools show log;

class UserAndPatternModel {
  String userName;
  bool isCheckUserName;
  List<PatternProductModelBuyer> pattenProductModels;
  UserAndPatternModel({
    required this.userName,
    required this.pattenProductModels,
    required this.isCheckUserName,
  });
}

class InCartPage extends StatefulWidget {
  const InCartPage({Key? key}) : super(key: key);

  @override
  State<InCartPage> createState() => _InCartPageState();
}

class _InCartPageState extends State<InCartPage> {
  List<UserAndPatternModel> userAndPatternModels = [];
  Set<String> nameUsers = {};
  Map<String, String> fakeContacts = {
    '1': 'Thanh TDG',
    '2': 'Nguyễn Hoàng Đăng Khoa',
    '3': 'Nhật Huy',
    '4': 'abcdfe',
    '5': 'fhdjfhd fdjhfjdfh',
    '6': 'fhdjdkf fhjkdhfjkd',
    '7': 'fdjhfdjkf dhfkdjhf',
    '8': 'fdhjfhdfk dkjfhdjkfh',
  };

  caculateTotalMoney() {
    for (var element in CartController.patternProductModelsCartChecked) {
      CartController.totalMoneyWhenChecked +=
          element.pattenProductModel.price!.toDouble() *
              element.pattenProductModel.amount!.toInt();
    }
  }

  getNameUserByIdPost() {
    for (var item in CartController.patternProductModelsCart) {
      String idUser = ProductPostController()
          .getByIdPatternProduct(item.pattenProductModel.idPost!)
          .post!
          .idUser!;
      if (fakeContacts.containsKey(idUser)) {
        nameUsers.add(fakeContacts[idUser]!);
      }
    }
  }

  String getUserByIdPost(String idUser) {
    String keyResult = fakeContacts.keys.where((element) {
      return element == idUser;
    }).first;

    return fakeContacts[keyResult]!;
  }

  getUserFromPattern() {
    for (var element in nameUsers) {
      List<PatternProductModelBuyer> patternProductsModelByUser = [];
      for (var element2 in CartController.patternProductModelsCart) {
        String idUser = ProductPostController()
            .getByIdPatternProduct(element2.pattenProductModel.idPost!)
            .post!
            .idUser!;
        String nameUser = getUserByIdPost(idUser);
        if (element == nameUser) {
          patternProductsModelByUser.add(element2);
        }
      }
      userAndPatternModels.add(UserAndPatternModel(
          userName: element,
          pattenProductModels: patternProductsModelByUser,
          isCheckUserName: CartController.patternProductModelsCartChecked
              .containsAll(patternProductsModelByUser)));
    }
  }

  renderUserAndPatternProducts() async {
    getNameUserByIdPost();
    getUserFromPattern();
  }

  @override
  void initState() {
    super.initState();
    renderUserAndPatternProducts();
    devtools.log(userAndPatternModels.length.toString());
  }

  Widget itemProduct(
          ProductPost productPost,
          PatternProductModelBuyer patternProductModelBuyer,
          int index,
          int index2) =>
      IntrinsicHeight(
        child: ItemPatternProduct(
          productPost: productPost,
          patternProductModelBuyer: patternProductModelBuyer,
          crossAxisAlignment: CrossAxisAlignment.start,
          onChange: (int val) {
            // devtools.log("amount max la: " +
            //     CartController.amountMax.toString());
            if (val < 1) {
              setState(() {
                patternProductModelBuyer.pattenProductModel.amount = 1;
                CartController().caculateTotalMoney();
                devtools.log(CartController.totalMoneyWhenChecked.toString());
              });
            } else if (val >= 1 && val < patternProductModelBuyer.amountMax) {
              setState(() {
                patternProductModelBuyer.pattenProductModel.amount = val;

                CartController().caculateTotalMoney();
                devtools.log(CartController.totalMoneyWhenChecked.toString());
              });
            } else if (val >= patternProductModelBuyer.amountMax) {
              setState(() {
                patternProductModelBuyer.pattenProductModel.amount =
                    patternProductModelBuyer.amountMax;

                CartController().caculateTotalMoney();
                devtools.log(CartController.totalMoneyWhenChecked.toString());
              });
            } else {
              setState(() {
                patternProductModelBuyer.pattenProductModel.amount = 0;

                CartController().caculateTotalMoney();
                devtools.log(CartController.totalMoneyWhenChecked.toString());
              });
            }
          },
          widthImage: SizeScreen.sizeBox * 2.5,
          maxLineNamePattern: 1,
          heightImage: SizeScreen.sizeBox * 2.8,
          widgetExtend: Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                setState(() {
                  CartController.patternProductModelsCart
                      .remove(patternProductModelBuyer);
                  CartController.patternProductModelsCartChecked
                      .remove(patternProductModelBuyer);
                  userAndPatternModels[index].pattenProductModels.remove(
                      userAndPatternModels[index]
                          .pattenProductModels
                          .elementAt(index2));
                  if (userAndPatternModels[index].pattenProductModels.isEmpty) {
                    userAndPatternModels.removeAt(index);
                  }
                  CartController().caculateTotalMoney();
                });
              },
              child: Text(
                'Xóa',
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.mainColor,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: SizeScreen.sizeBox * 1.5,
          child: Container(
            margin: EdgeInsets.only(top: SizeScreen.sizeSpace),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    child: CheckboxListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Text(
                        'Tất cả (${CartController.patternProductModelsCartChecked.length} sản phẩm)',
                        style: AppTextStyles.h3
                            .copyWith(color: AppColors.greyBlur),
                      ),
                      value: CartController.patternProductModelsCart.length ==
                              CartController
                                  .patternProductModelsCartChecked.length &&
                          CartController
                              .patternProductModelsCartChecked.isNotEmpty,
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      secondary: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.mainColor,
                        ),
                        onPressed: () {
                          setState(() {
                            var listDeleteInCart = CartController
                                .patternProductModelsCart
                                .where((element) => CartController
                                    .patternProductModelsCartChecked
                                    .contains(element))
                                .toList();

                            for (var element in userAndPatternModels) {
                              element.pattenProductModels.removeWhere(
                                  (element) => CartController
                                      .patternProductModelsCartChecked
                                      .contains(element));
                            }
                            userAndPatternModels.removeWhere((element) =>
                                element.pattenProductModels.isEmpty);
                            CartController.patternProductModelsCart
                                .removeAll(listDeleteInCart);
                            CartController.patternProductModelsCartChecked
                                .clear();
                          });

                          // userAndPatternModels.clear();
                          CartController().caculateTotalMoney();
                        },
                      ),
                      activeColor: AppColors.mainColor,
                      contentPadding:
                          EdgeInsets.only(right: SizeScreen.sizeSpace),
                      onChanged: (bool? value) {
                        if (value!) {
                          setState(
                            () {
                              for (var element in userAndPatternModels) {
                                element.isCheckUserName = true;
                                CartController.patternProductModelsCartChecked
                                    .addAll(element.pattenProductModels);
                              }
                              CartController().caculateTotalMoney();
                            },
                          );
                        } else {
                          setState(
                            () {
                              for (var element in userAndPatternModels) {
                                element.isCheckUserName = false;
                                CartController.patternProductModelsCartChecked
                                    .clear();
                              }
                              CartController().caculateTotalMoney();
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.greyBlur,
                    thickness: 1,
                  ),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userAndPatternModels.length,
                    itemBuilder: ((context, index) {
                      // valuesMatchKeys =
                      //     fakeProducts[fakeContacts.keys.elementAt(index)]!;
                      return SingleChildScrollView(
                        child: Column(children: [
                          ///note: name user checkbox
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: AppColors.mainColor),
                              ),
                              color: Colors.white,
                            ),
                            child: CheckboxListTile(
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: 0),
                              title: UserSell(
                                name: userAndPatternModels[index].userName,
                              ),
                              value:
                                  userAndPatternModels[index].isCheckUserName,
                              controlAffinity: ListTileControlAffinity.leading,
                              checkColor: Colors.white,
                              activeColor: AppColors.mainColor,
                              contentPadding:
                                  EdgeInsets.only(right: SizeScreen.sizeSpace),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    userAndPatternModels[index]
                                            .isCheckUserName =
                                        !userAndPatternModels[index]
                                            .isCheckUserName;
                                    CartController
                                        .patternProductModelsCartChecked
                                        .addAll(userAndPatternModels[index]
                                            .pattenProductModels);

                                    CartController().caculateTotalMoney();
                                  });
                                } else {
                                  setState(() {
                                    userAndPatternModels[index]
                                            .isCheckUserName =
                                        !userAndPatternModels[index]
                                            .isCheckUserName;
                                    for (var item in userAndPatternModels[index]
                                        .pattenProductModels) {
                                      CartController
                                          .patternProductModelsCartChecked
                                          .removeWhere(
                                              (element) => element == item);
                                    }
                                    devtools.log(CartController
                                        .patternProductModelsCartChecked.length
                                        .toString());
                                    CartController().caculateTotalMoney();
                                  });
                                }
                              },
                            ),
                          ),

                          ///note: pattern product
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: AppColors.grey),
                              ),
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: userAndPatternModels[index]
                                  .pattenProductModels
                                  .length,
                              itemBuilder: (context, index2) {
                                PatternProductModelBuyer pattenProductModel =
                                    userAndPatternModels[index]
                                        .pattenProductModels
                                        .elementAt(index2);
                                return CheckboxListTile(
                                  visualDensity: const VisualDensity(
                                      vertical: -4, horizontal: 0),
                                  title: itemProduct(
                                      ProductPostController()
                                          .getByIdPatternProduct(
                                              pattenProductModel
                                                  .pattenProductModel.idPost!),
                                      pattenProductModel,
                                      index,
                                      index2),
                                  value: CartController
                                      .patternProductModelsCartChecked
                                      .contains(pattenProductModel),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  checkColor: Colors.white,
                                  activeColor: AppColors.mainColor,
                                  contentPadding: EdgeInsets.only(
                                      right: SizeScreen.sizeSpace),
                                  onChanged: (bool? value) {
                                    if (value!) {
                                      setState(() {
                                        CartController
                                            .patternProductModelsCartChecked
                                            .add(pattenProductModel);
                                        CartController().caculateTotalMoney();
                                        if (CartController
                                            .patternProductModelsCartChecked
                                            .containsAll(
                                                userAndPatternModels[index]
                                                    .pattenProductModels)) {
                                          userAndPatternModels[index]
                                              .isCheckUserName = true;
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        CartController
                                            .patternProductModelsCartChecked
                                            .remove(pattenProductModel);

                                        CartController().caculateTotalMoney();
                                        if (!CartController
                                            .patternProductModelsCartChecked
                                            .containsAll(
                                                userAndPatternModels[index]
                                                    .pattenProductModels)) {
                                          userAndPatternModels[index]
                                              .isCheckUserName = false;
                                        }
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ]),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: AppColors.mainColor,
                  width: 1,
                ))),
            height: SizeScreen.sizeBox * 1.5,
            child: BottomStack(
              totalMoney: CartController.totalMoneyWhenChecked,
            ),
          ),
        )
      ],
    );
  }
}
