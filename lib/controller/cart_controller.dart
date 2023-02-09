import 'package:flutter/material.dart';
import 'package:student_app/model/shop/patten_product_model.dart';
import 'package:student_app/model/shop/pattern_product_model_buyer.dart';
import 'package:student_app/service/action/shop/patten_product_acction.dart';

import '../model/shop/post_model.dart';
import 'dart:developer' as devtools show log;

class CartController with ChangeNotifier {
  static List<PatternProductModelBuyer> patternProductModels = [];
  static Set<PatternProductModelBuyer> patternProductModelsCart = {};
  static Set<PatternProductModelBuyer> patternProductModelsCartChecked = {};

  static Set<PattenProductModel> patternProductModelsCartHadBuy = {};

  static double totalMoneyWhenChecked = 0;

  // static int amountMax = PatternProductAction()
  //     .findAmountMaxPatternOrigin(PatternProductAction.patternProductSelected);

  Future getPatternProducts(PostModel postModel) async {
    patternProductModels =
        await PatternProductAction().getPatternProductFromFirebase(postModel);
  }

  caculateTotalMoney() {
    totalMoneyWhenChecked = 0;
    for (var element in CartController.patternProductModelsCartChecked) {
      totalMoneyWhenChecked += element.pattenProductModel.price!.toDouble() *
          element.pattenProductModel.amount!.toInt();
    }

    devtools.log(CartController.totalMoneyWhenChecked.toString());
    notifyListeners();
  }
}
