import 'package:student_app/service/other/json_manager.dart';
import 'package:student_app/service/other/range_money_action.dart';

class ConfigCategory {
  Future getRangeMoney() async {
    RangeMoneyAction.rangeMoneys = await JsonManager().readJsonRangeMoney();
    for (var item in RangeMoneyAction.rangeMoneys) {
      print("log ${item.idRangeMoney}");
    }
    // RangeMoneyAction.rangeMoneys.forEach((element) {
    //   ContactAction().addContact(contact: element);
    // });
  }
}
