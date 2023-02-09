import 'package:student_app/config/string/string_job.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/service/action/job/job_action.dart';
import 'package:student_app/service/action/job/job_category_fields_action.dart';
import 'package:student_app/service/action/shop/post_action.dart';
import 'package:student_app/service/other/json_manager.dart';

import '../../config/string/string_category.dart';
import '../../config/string/string_price.dart';
import '../../config/string/string_utility.dart';
import '../../controller/hotel_filter.dart';
import '../../model/other/range_money.dart';

class RangeMoneyAction {
  static List<RangeMoney> rangeMoneys = [];

  String getRangeMoney({required double? money}) {
    if (money == null) return StringPrice.idDefault;
    for (var range in rangeMoneys) {
      if (range.min! <= money && money < range.max!) {
        return range.idRangeMoney!;
      }
    }
    return StringPrice.idDefault;
  }

  getRangeForPost() {
    for (var post in PostAction.posts) {
      post.idRangeMoney = getRangeMoney(money: post.priceLow);
    }
  }

  getRangeForJob() {
    for (var job in JobFilter.listJob) {
      job.idRangeMoney = getRangeMoney(money: job.salaryMin);
    }
  }

  getRangeForHotel() {
    for (var motel in HotelFilter.listHotel) {
      motel.idRangeMoney = getRangeMoney(money: motel.price);
    }
  }

  Future<List<RangeMoney>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlRangeMoney,
        nameType: StringCategory.rangerMoneyCategory);
    return list.map((e) => RangeMoney.fromJson(e)).toList();
  }

  List<String> getListRageMony({required double min, required double max}) {
    List<String> idRangeMoneys = [];
    for (var range in rangeMoneys) {
      if (range.max! < min) {
        continue;
      }
      idRangeMoneys.add(range.idRangeMoney!);
      if (range.max! > max) {
        break;
      }
    }
    return idRangeMoneys;
  }
}
