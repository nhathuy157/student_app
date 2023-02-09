import 'dart:developer';

import 'package:student_app/model/other/category.dart';
import 'package:student_app/model/hotel/category_capacity_hotel.dart';
import 'package:student_app/model/hotel/category_type_hotel.dart';
import 'package:student_app/model/job/job_natural.dart';
import 'package:student_app/model/other/location_category.dart';
import 'package:student_app/model/other/type_salary.dart';
import 'package:student_app/model/shop/shop_category.dart';
import 'package:student_app/service/action/hotel/hotel_category_capacity.dart';
import 'package:student_app/service/action/hotel/hotel_category_type.dart';
import 'package:student_app/service/action/job/job_category_natural_action.dart';
import 'package:student_app/service/action/shop/shop_category.dart';
import 'package:student_app/service/other/category_location.dart';
import 'package:student_app/service/other/range_money_action.dart';

import '../model/job/category_job_fields_model.dart';
import '../model/other/range_money.dart';
import '../service/action/job/job_category_fields_action.dart';
import '../service/other/type_salary_orther.dart';

class CategoryController {
  static List<ShopCategory> shopCategories = [];
  static List<LocationCategory> locationCategories = [];
  static List<JobField> jobFieldCategories = [];
  static List<JobNatural> jobNaturalCategories = [];
  static List<RangeMoney> rangeMoneys = [];
  static List<CategoryCapacityHotel> capacityHotel = [];
  static List<CategoryTypeHotel> typeHotel = [];
  static List<TypeSalary> typeSalary = [];

  Future<bool> getShopCategory() async {
    if (shopCategories.isEmpty) {
      shopCategories = await ShopCategoryAction().getFormFirebase();
    }
    return shopCategories.isNotEmpty;
  }

  List<Category> locationConvertToCategories() {
    List<Category> list = [];
    for (var location in locationCategories) {
      list.add(
          Category(id: location.idLocation!, name: location.nameLocation!));
    }
    return list;
  }

  Future<bool> getLocationCategory() async {
    if (locationCategories.isEmpty) {
      locationCategories = await LocationCategoryAction().getFromFirebase();
    }
    return locationCategories.isNotEmpty;
  }

  List<Category> fieldConvertToCategories() {
    List<Category> list = [];
    for (var field in jobFieldCategories) {
      list.add(Category(id: field.idCategoryFields!, name: field.name!));
    }
    return list;
  }

  Future<bool> getFieldCategory() async {
    if (jobFieldCategories.isEmpty) {
      jobFieldCategories = await JobFieldsAction().getFromFirebase();
    }
    return jobFieldCategories.isEmpty;
  }

  List<Category> naturalConvertToCategories() {
    List<Category> list = [];
    for (var natural in jobNaturalCategories) {
      list.add(Category(id: natural.idCategoryNatural!, name: natural.name!));
    }
    return list;
  }

  Future<bool> getNaturalCategory() async {
    if (jobNaturalCategories.isEmpty) {
      jobNaturalCategories = await JobNaturalAction().getFromFirebase();
    }
    return jobNaturalCategories.isNotEmpty;
  }

  List<Category> rangeMoneyConvertToCategories() {
    List<Category> list = [];
    for (var rangerMoney in rangeMoneys) {
      list.add(Category(
          id: rangerMoney.idRangeMoney!, name: rangerMoney.toString()));
    }
    return list;
  }

  Future<bool> getRangeMoneys() async {
    if (rangeMoneys.isEmpty) {
      rangeMoneys = await RangeMoneyAction().getFromFirebase();
    }
    return rangeMoneys.isNotEmpty;
  }

  List<Category> hotelCapacityConvertToCategories() {
    List<Category> list = [];
    for (var capacity in capacityHotel) {
      list.add(
          Category(id: capacity.idCategoryCapacity!, name: capacity.name!));
    }
    return list;
  }

  Future<bool> getHotelCapacity() async {
    if (capacityHotel.isEmpty) {
      capacityHotel = await HotelCapacityAction().getFromFirebase();
    }
    return capacityHotel.isNotEmpty;
  }

  Future<bool> getHotelType() async {
    if (typeHotel.isEmpty) {
      typeHotel = await HotelTypeAction().getFromFirebase();
    }
    return typeHotel.isNotEmpty;
  }

  List<Category> hotelTypeConvertToCategories() {
    List<Category> list = [];
    for (var typeHotel in typeHotel) {
      list.add(Category(
          id: typeHotel.idCategoryType!,
          name: typeHotel.name!,
          img: typeHotel.images));
    }
    return list;
  }

  Future<bool> getTypeSalary() async {
    if (typeSalary.isEmpty) {
      typeSalary = await TypeSalaryAction().getFromFirebase();
    }
    return typeHotel.isNotEmpty;
  }

  String getValueSalary(String? id) {
    if (id == null) return "";
    for (var element in typeSalary) {
      if (element.id == id) {
        return "/ " + element.value;
      }
    }
    return "";
  }
}
