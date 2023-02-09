import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:student_app/config/string/string_hotel.dart';

import '../../../config/string/string_price.dart';
import '../../../config/string/string_utility.dart';
import '../../../constants/assets_part.dart';
import '../../../constants/constant.dart';
import '../../../controller/utility.dart';
import '../../../model/hotel/hotel.dart';

class HotelAction {
  static bool lastDefault = false;
  static bool lastFelid = false;
  static bool lastSearch = false;
  Hotel hotelNewLast = Hotel();
  List<Hotel> lastGetDefaults = [];
  List<Hotel> lastGetResults = [];

  static const limitResult = 10;
  final CollectionReference HotelCollection =
      FirebaseFirestore.instance.collection(StringHotel.hotel);

  Future<List<Hotel>> ReadJsonHotel() async {
    final jsonData = await rootBundle.loadString(DataAssets.hotelData);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => Hotel.fromJson(e)).toList();
  }

  Future addHotel({required Hotel hotel}) async {
    await HotelCollection.doc(hotel.idHotel).set(hotel.toDynamic());
  }

  Future getNewHotel({bool showMore = false, String search = ""}) async {
    List<Hotel> Hotels = [];
    Query query = HotelCollection.limit(limitResult);
    if (search.isNotEmpty) {
      query = query.where(StringUtility.keyWord,
          arrayContainsAny: getKeyWorld(search));
    }
    if (showMore) {
      query = query.startAfterDocument(
          await getDocumentReferentByID(hotelNewLast.idHotel!));
    }
    QuerySnapshot snapshot = await query.limit(limitResult).get();
    Hotels.addAll(getFormSnapShot(snapshot));

    if (Hotels.isNotEmpty) {
      // Hotels.sort(
      //     (a, b) => b.timePost!.compareTo(a.timePost!),
      //     );
      hotelNewLast = Hotels.last;
    }

    return Hotels;
  }

  List<Hotel> getFormSnapShot(QuerySnapshot snapshot) {
    List<Hotel> list = [];
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      snapshot.docs.forEach((element) {
        list.add(Hotel.fromSnapshot(element));
      });
      return list;
    }
  }

  Future<List<Hotel>> getHotelByQuery(
      {required List<Hotel> hotels, bool showMore = false}) async {
    List<Hotel> hotelResults = [];
    List<Hotel> listLast = [];
    for (var hotel in (showMore ? lastGetDefaults : hotels)) {
      Query query = HotelCollection;
      if (showMore) {
        query = query
            .startAfterDocument(await getDocumentReferentByID(hotel.idHotel!));
      }
      if (hotel.idCategoryCapacity != null) {
        query = query.where(StringHotel.idCapacity,
            isEqualTo: hotel.idCategoryCapacity);
      }
      if (hotel.idCategoryType != null) {
        query =
            query.where(StringHotel.idType, isEqualTo: hotel.idCategoryType);
      }
      if (hotel.idLocation != null) {
        query =
            query.where(StringUtility.idLocation, isEqualTo: hotel.idLocation);
      }
      if (hotel.idRangeMoney != null) {
        query = query.where(StringPrice.idRangeMoney,
            isEqualTo: hotel.idRangeMoney);
      }
      QuerySnapshot snapshot = await query.limit(LIMIT).get();
      hotelResults.addAll(getFormSnapShot(snapshot));
      if (hotelResults.isNotEmpty) {
        listLast.add(hotelResults.last);
      }
    }
    lastGetDefaults.clear();
    lastGetDefaults.addAll(listLast);
    return hotelResults;
  }

  Future<DocumentSnapshot> getDocumentReferentByID(String id) async {
    return await HotelCollection.doc(id).get();
  }
}
