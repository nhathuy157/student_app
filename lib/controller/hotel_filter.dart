import 'package:student_app/service/action/hotel/hotel_action.dart';

import '../model/hotel/hotel.dart';
import '../service/action/job/job_action.dart';

class HotelFilter {
  static List<String> listFilterType = [];
  static List<String> listFilterCapacity = [];
  static List<String> listRangeMoney = [];
  static List<String> listLocation = [];
  static List<Hotel> listHotel = [];
  static List<Hotel> listFilter = [];
  static List<Hotel> listSearch = [];
  static bool isNew = false;

  Future initData() async {
    if (listFilterType.isEmpty &&
        listFilterCapacity.isEmpty &&
        listRangeMoney.isEmpty &&
        listLocation.isEmpty) {
      listHotel = await HotelAction().getNewHotel();
    } else {
      listHotel =
          await HotelAction().getHotelByQuery(hotels: _getListObjectFilter());
    }
  }

  Future getSearch(String term) async {
    if (isNew) {
      listSearch = await HotelAction().getNewHotel(
        search: term,
      );
    } else {}
  }

  Hotel? getHotel(String idHotel) {
    int index = listHotel.indexWhere((element) => element.idHotel == idHotel);
    if (index == -1) {
      return null;
    } else {
      return listHotel[index];
    }
  }

  Future getSearchHotel(String term) async {
    if (isNew) {
      listSearch = await HotelAction().getNewHotel(
        search: term,
      );
    } else {}
  }

  List<Hotel> _getListObjectFilter() {
    List<Hotel> list = [];

    int i = 0;
    int j = 0;
    int k = 0;
    int h = 0;

    int fLengthFilterType = listFilterType.length;
    int fLengthFilterCapacity = listFilterCapacity.length;
    int fLengthRangeMoney = listRangeMoney.length;
    int fLengthLocation = listLocation.length;

    int ii = fLengthFilterType > 0 ? 1 : 0;
    int ij = fLengthFilterCapacity > 0 ? 1 : 0;
    int ik = fLengthRangeMoney > 0 ? 1 : 0;
    int il = fLengthLocation > 0 ? 1 : 0;

    for (i = ii; i <= fLengthFilterType; i++) {
      for (j = ij; j <= fLengthFilterCapacity; j++) {
        for (k = ik; k <= fLengthRangeMoney; k++) {
          for (h = il; h <= fLengthLocation; h++) {
            Hotel hotel = Hotel();
            if (i > 0) {
              hotel.idCategoryType = listFilterType[i - 1];
            }
            if (j > 0) {
              hotel.idCategoryCapacity = listFilterCapacity[j - 1];
            }
            if (k > 0) {
              hotel.idRangeMoney = listRangeMoney[k - 1];
            }
            if (h > 0) {
              hotel.idLocation = listLocation[h - 1];
            }
            list.add(hotel);
          }
        }
      }
    }
    return list;
  }
}
