import 'dart:developer';
import 'dart:ffi';

import 'package:intl/intl.dart' as intl;
import 'package:student_app/constants/constant.dart';
import 'package:student_app/model/other/category.dart';
import 'package:student_app/widgets/stateless/id_developing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../config/string/remove_lap.dart';
import '../config/string/string_app.dart';

String priceToVND(double price) {
  return intl.NumberFormat.currency(locale: 'vi', symbol: '₫').format(price);
}

DateTime? stringToDay(String day) {
  return DateTime.tryParse(day);
}


Future OpenBrowserURL({required String url}) async {
  final Uri _url = Uri.parse(url);
  if (await canLaunchUrl(_url)) {
    await launchUrlString(url);
  } else {
    ToastLog.toast(StringApp.notConnect);
  }
}

String priceToTerm(int price, double division) {
  if (price > 0) {
    if (division == THOUSAND) {
      return intl.NumberFormat.currency(locale: 'vi', symbol: 'ngàn')
          .format(price ~/ division);
    } else {
      return intl.NumberFormat.currency(locale: 'vi', symbol: 'triệu')
          .format(price);
    }
  } else {
    return "";
  }
}

String priceToString(double price) {
  String str = "";
  str += priceToTerm((price ~/ MILLION), MILLION);
  str += " " + priceToTerm((price % MILLION).toInt(), THOUSAND);
  return str;
}

String getNumberSelected(List<String> list) {
  if (list.length > 0) {
    return "(${list.length})";
  } else {
    return "";
  }
}

List<Category> sortCategorySelect(
    {required List<String> selected, required List<Category> categories}) {
  if (selected.isNotEmpty) {
    categories = categories.reversed.toList();
    for (var select in selected) {
      Category category = categories[
          categories.indexWhere((category) => category.id == select)];
      categories.remove(category);
      categories.add(category);
    }
    categories = categories.reversed.toList();
    return categories;
  }
  return categories;
}

List<String> getKeyWorld(String str) {
  int startIndex = 3;
  int maxTerm = 3;
  List<String> listKeyWorld = [];
  if (str.isNotEmpty) {
    str = removeDiacritics(str);
    List<String> terms = str.toLowerCase().split(" ");
    // for (var item in items) {

    // }

    for (String term in terms) {
      listKeyWorld.add(term);
      // if (term.length >= startIndex) {
      //   for (int i = startIndex; i < term.length - 1; i++) {
      //     listKeyWorld.add(term.substring(0, i));
      //   }
      // }
    }
  }
  return listKeyWorld;
}

final diacriticsMap = {};

final diacriticsRegExp = RegExp('[^\u0000-\u007E]', multiLine: true);

String removeDiacritics(String str) {
  if (diacriticsMap.isEmpty) {
    for (int i = 0; i < defaultDiacriticsRemovalap.length; i++) {
      var letters = defaultDiacriticsRemovalap[i]['letters'];
      for (int j = 0; j < letters!.length; j++) {
        diacriticsMap[letters[j]] = defaultDiacriticsRemovalap[i]['base'];
      }
    }
  }

  return str.replaceAllMapped(diacriticsRegExp, (a) {
    return diacriticsMap[a.group(0)] ?? a.group(0);
  });
}
