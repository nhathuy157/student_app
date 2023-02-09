import 'package:student_app/model/shop/pattern_product_model_buyer.dart';
import 'package:student_app/service/action/shop/patten_product_acction.dart';

class PatternProductModelBuyerAction {
  static List<PatternProductModelBuyer> patternProductModelBuyers = [];
  static PatternProductModelBuyer patternProductModelBuyerSelected =
      patternProductModelBuyers[0];

  getPatternProductBuyerFromPatternProduct() {
    for (var element in PatternProductAction.pattenProducts) {
      patternProductModelBuyers.add(
        PatternProductModelBuyer(
          pattenProductModel: element,
          amountMax: element.amount!,
        ),
      );
    }
  }
}
