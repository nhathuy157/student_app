import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_app/controller/hotel_filter.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../model/hotel/hotel.dart';
import '../../../model/other/search_model.dart';
import '../../../widgets/stateful/list_img_info.dart';
import '../../../widgets/stateless/image_found.dart';

class HotelDetailsPage extends StatefulWidget {
  String idHotel;
  HotelDetailsPage({Key? key, required this.idHotel}) : super(key: key);

  get img => null;

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  Hotel? hotel;
  bool loading = true;

  getData() {
    hotel = HotelFilter().getHotel(widget.idHotel);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String bullet = "\u2022" " ";
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ListImgInfo(URLImages: hotel!.img ?? []),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  hotel!.name!,
                  style: AppTextStyles.h2
                      .copyWith(color: AppColors.orangeryYellow),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: size.width * 9.3 / 10,
              height: size.height * 1.7 / 10,
              decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 6),
                        blurRadius: 6)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        bullet + ' ' + hotel!.address!,
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorBold),
                      ),
                    ),
                    Container(
                      child: Text(
                        bullet + hotel.toString(),
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    Container(
                      child: Text(bullet + ' Diện tích : ' + hotel!.area!,
                          style: AppTextStyles.h4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  'Mô tả',
                  style: AppTextStyles.h4.copyWith(
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: size.width * 9.3 / 10,
              height: size.height * 4 / 10,
              decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 6),
                        blurRadius: 6)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Text(hotel!.description!, style: AppTextStyles.h4),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class SearchModel {}
