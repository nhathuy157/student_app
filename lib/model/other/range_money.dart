import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/string/string_price.dart';
import 'package:student_app/controller/utility.dart';

class RangeMoney {
  String? idRangeMoney;
  double? min;
  double? max;

  RangeMoney({this.idRangeMoney, this.max, this.min});

  factory RangeMoney.fromJson(Map<String, dynamic> responseData) {
    return RangeMoney(
      idRangeMoney: responseData[StringPrice.idRangeMoney],
      min: double.tryParse(responseData[StringPrice.min].toString()),
      max: double.tryParse(responseData[StringPrice.max].toString()),
    );
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringPrice.idRangeMoney: idRangeMoney,
      StringPrice.max: max,
      StringPrice.min: min,
    };
    return toData;
  }

  @override
  String toString() {
    String str = "";
    if (max != null) {
      str += min == 0 ? StringApp.below : priceToString(min!);
      str += min == 0 ? " " : " ~ ";
      str += priceToString(max!);
    } else {
      str += StringApp.over + " " + priceToString(min!);
    }
    return str;
  }
}
