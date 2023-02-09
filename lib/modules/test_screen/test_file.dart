import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:student_app/service/other/config_categories.dart';
import 'package:student_app/service/action/hotel/fake_data.dart';
import 'package:student_app/service/action/shop/shop_category.dart';
import 'package:student_app/service/other/data_services.dart';
import 'package:student_app/service/other/json_manager.dart';

import '../../config/string/string_category.dart';
import '../../service/other/fake_user.dart';
import '../../service/action/job/fake_data.dart';
import '../../service/action/map/fake_data_map.dart';

class TestFilePage extends StatelessWidget {
  const TestFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            DataServices()
                .uploadToStorage(
                    JsonManager().categoriesToJson(
                        nameCategory: StringCategory.category,
                        list: ShopCategoryAction.categoryShops),
                    StringCategory.category,
                    StringCategory.shopCategory)
                .whenComplete(
                  () => log("done set category "),
                );
            DataServices()
                .uploadToStorage(
                    JsonManager().categoriesToJson(
                        nameCategory: StringCategory.category,
                        list: ShopCategoryAction.categoryShops),
                    StringCategory.category,
                    StringCategory.shopCategory)
                .whenComplete(
                  () => log("done set category "),
                );
          },
          child: Text("put json"),
        ),
        ElevatedButton(
          onPressed: () {
            ShopCategoryAction().getFormFirebase();
          },
          child: Text("get Json form store"),
        ),
        ElevatedButton(
          onPressed: () {
            FakeDataMap().totalAddBuilding();
          },
          child: Text("get DataMap"),
        ),
        ElevatedButton(
          onPressed: () {
            FakeDataJob().getJsonData();
          },
          child: Text("get Data Job"),
        ),
        ElevatedButton(
          onPressed: () {
            FakeUser().GetContactFake();
          },
          child: Text("Get contact"),
        ),
        ElevatedButton(
          onPressed: () {
            ConfigCategory().getRangeMoney();
          },
          child: Text("Get rage Money"),
        ),
        ElevatedButton(
          onPressed: () {
            FakeDataHotel().getJsonData();
          },
          child: Text("Get Data Hotel"),
        ),
      ]),
    );
  }
}
