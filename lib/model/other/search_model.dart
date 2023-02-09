import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:student_app/config/string/string_job.dart';

enum TypeSearch {
  job,
  shop,
  motel,
}

class SearchModel {
  static String _searchJob = "";
  static String _searchHotel = "";
  static String _searchShop = "";
  static TypeSearch typeSearch = TypeSearch.job;

  String get searchJob => _searchJob;
  set searchJob(String searchJob) {
    _searchJob = searchJob;
  }

  String get searchHotel => _searchHotel;
  set searchHotel(String searchMotel) {
    _searchHotel = searchMotel;
  }

  String get searchShop => _searchJob;
  set searchShop(String searchShop) {
    _searchShop = searchShop;
  }
}
