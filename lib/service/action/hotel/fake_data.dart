import 'package:student_app/controller/hotel_filter.dart';
import 'package:student_app/service/action/hotel/hotel_action.dart';
import 'package:student_app/service/action/hotel/hotel_category_capacity.dart';
import 'package:student_app/service/action/hotel/hotel_category_type.dart';

import '../../other/range_money_action.dart';

class FakeDataHotel {
  Future getJsonData() async {
    // await HotelCapacityAction().ReadJsonHotelCategoryCapacity();
    // await HotelTypeAction().ReadJsonHotelCategoryType();
    HotelFilter.listHotel = await HotelAction().ReadJsonHotel();
    RangeMoneyAction().getRangeForHotel();

    await JobToFireBase();
  }

  Future JobToFireBase() async {
    for (var hotel in HotelFilter.listHotel) {
      await HotelAction().addHotel(hotel: hotel);
    }
  }
}
