import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/hotel_filter.dart';
import 'package:student_app/service/action/hotel/hotel_action.dart';

import '../../../config/string/string_app.dart';
import '../../../config/string/string_use.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../model/hotel/hotel.dart';
import '../../../model/other/search_model.dart';
import '../../../widgets/stateful/my_search.dart';
import '../../../widgets/stateful/search_page.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../../../widgets/stateless/icon_inside.dart';
import '../../../widgets/stateless/search_widget.dart';
import '../../page_temp.dart';
import '../widget/item_listview_motel.dart';

class HotelPage extends StatefulWidget {
  String? search;
  HotelPage({this.search, Key? key}) : super(key: key);

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  List<Hotel> listHotel = [];

  bool loading = true;

  Future getData() async {
    await HotelFilter().initData();
    listHotel = HotelFilter.listHotel;
  }

  @override
  void initState() {
    getData().whenComplete(() {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          loading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.lightGreen,
        title: const Text(
          StringApp.accommodation,
          style: AppTextStyles.h2,
        ),
        elevation: 4,
        actions: [
          // SearchWidget(
          //   numberIcon: 2,
          //   string: StringUse.motelFilter,
          //   onTap: () async {
          //     SearchModel().searchHotel = (await myShowSearch(
          //         context: context, delegate: CustomSearch()));
          //     if (SearchModel().searchHotel.isNotEmpty) {
          //       setState(() {});
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (_) => PageTemp()),
          //       );
          //     }
          //   },
          //   // Đến đây
          // ),
          // ignore: prefer_const_constructors
          IconButtonRounded(
            customWidget: IconInside(
              iconCustom: Icon(Icons.star),
              color: AppColors.orangeryYellow,
              onClick: () {},
            ),
            showDecoration: false,
          )
        ],
        leading: IconButtonBack(),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listHotel.length,
                  itemBuilder: (BuildContext context, index) {
                    return ItemListViewHotel(
                        textNameHotel: listHotel[index].name!,
                        textAddress: listHotel[index].address!,
                        textPrice: listHotel[index].toString(),
                        img: listHotel[index].img == null
                            ? ""
                            : listHotel[index].img![0],
                        idHotel: listHotel[index].idHotel!);
                  })),
        )
      ]),
    );
  }
}
