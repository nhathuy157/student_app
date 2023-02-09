// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_utility.dart';
import 'package:student_app/controller/utility.dart';

import 'package:student_app/widgets/stateless/icon_inside.dart';

import '../../../config/routes/routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../constants/assets_part.dart';
import '../../../service/size_screen.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../../../widgets/stateless/id_developing.dart';
import '../widget/item_banner.dart';
import '../widget/item_bottombar.dart';
import '../widget/item_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Student App',
          style: AppTextStyles.h2,
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightGreen,
        elevation: 4,
        actions: [
          IconButtonRounded(
            customWidget: IconInside(
                iconCustom: Icon(Icons.menu_outlined),
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.testScreen);
                }),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_sharp),
          color: AppColors.mainColor,
          iconSize: SizeScreen.sizeBox,
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 1.9 / 10,
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  CarouselSlider(
                    // ignore: prefer_const_literals_to_create_immutables
                    items: [
                      ItemBanner(images: ImgAssets.images1),
                      ItemBanner(images: ImgAssets.images1),
                      ItemBanner(images: ImgAssets.images2),
                      ItemBanner(images: ImgAssets.images3),
                      ItemBanner(images: ImgAssets.images4),
                    ],
                    options: CarouselOptions(
                        height: 137,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8),
                  )
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * 3.7 / 10,
                  color: AppColors.lightGreen,
                ),
                Container(
                    height: size.height * 3.7 / 10,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(85)))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(top: 8, left: 24),
                        child: Text(
                          'Đại học Đà Lạt',
                          style: AppTextStyles.h4.copyWith(
                              color: AppColors.orangeryYellow,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemHome(
                            iconHome: const Icon(Icons.rate_review_outlined),
                            textHome: 'Giới thiệu',
                            onTapTo: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.infoSchoolPage);
                            },
                          ),
                          ItemHome(
                            textHome: 'DLU Connect',
                            assetPath: ImgAssets.logoDluConnect,
                            onTapTo: () {
                              OpenBrowserURL(
                                  url: StringUtility.urlDLUConnection);
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.home_work_rounded),
                            textHome: 'Khoa',
                            onTapTo: () {
                              ToastLog.isDeveloping();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemHome(
                            iconHome: const Icon(Icons.reviews),
                            textHome: 'Giới thiệu',
                            onTapTo: () {
                              ToastLog.isDeveloping();
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.search),
                            textHome: 'Giới thiệu',
                            onTapTo: () {
                              ToastLog.isDeveloping();
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.search),
                            textHome: 'Giới thiệu',
                            onTapTo: () {
                              ToastLog.isDeveloping();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * 3.7 / 10,
                  color: Colors.white,
                ),
                Container(
                    height: size.height * 3.7 / 10,
                    decoration: const BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(85)))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(top: 8, left: 24),
                        child: Text(
                          'Tiện ích',
                          style: AppTextStyles.h4.copyWith(
                              color: AppColors.orangeryYellow,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemHome(
                            iconHome: const Icon(Icons.fastfood_rounded),
                            textHome: 'Ăn uống',
                            onTapTo: () {
                              ToastLog.isDeveloping();
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.store_rounded),
                            textHome: 'Chỗ ở',
                            onTapTo: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.askHotelPage);
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.storefront_outlined),
                            textHome: 'Đồ cũ',
                            onTapTo: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.shoppingPage);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemHome(
                            iconHome: const Icon(Icons.work_outline),
                            textHome: 'Việc làm',
                            onTapTo: () {
                              Navigator.of(context).pushNamed(Routes.jobPage);
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.search),
                            textHome: 'Giới thiệu',
                            onTapTo: () {
                              Navigator.of(context).pushNamed(Routes.jobPage);
                            },
                          ),
                          ItemHome(
                            iconHome: const Icon(Icons.search),
                            textHome: 'Giới thiệu',
                            onTapTo: () {
                              ToastLog.isDeveloping();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.lightGreen,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Container(
            height: 64,
            color: Colors.white,
            child: TabBar(
              labelColor: AppColors.mainColor,
              unselectedLabelColor: Colors.white,
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.black54, width: 0),
                  insets: EdgeInsets.fromLTRB(50, 0, 40, 40)),

              //For Indicator Show and Custonization
              indicatorColor: Colors.black,
              tabs: <Widget>[
                ItemBottomBar(
                    iconBottomBar: const Icon(Icons.home_outlined),
                    onTap: () {}),
                ItemBottomBar(
                    iconBottomBar: const Icon(Icons.map_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.mapPage);
                    }),
                ItemBottomBar(
                    iconBottomBar: const Icon(Icons.notifications_outlined),
                    onTap: () {
                      ToastLog.isDeveloping();
                    }),
                ItemBottomBar(
                    iconBottomBar: const Icon(Icons.person_outline),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.signInPage);
                    }),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
