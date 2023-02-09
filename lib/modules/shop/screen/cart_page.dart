import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/shop/screen/in_cart_page.dart';
import 'package:student_app/widgets/stateless/dismissble_page.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TabBar get _tabBar => const TabBar(
        indicatorColor: AppColors.mainColor,
        labelPadding: EdgeInsets.symmetric(horizontal: 2),
        labelColor: AppColors.mainColor,
        tabs: [
          Tab(
            text: 'Trong giỏ',
          ),
          Tab(
            text: 'Chờ xác nhận',
          ),
          Tab(
            text: 'Đã mua',
          ),
          Tab(
            text: 'Đã hủy',
          ),
        ],
      );


  @override
  void initState() {
    super.initState();
  }

  void exitPage() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitPage();
        return false;
      },
      child: DismissiblePageCustom(
        function: () {
          exitPage();
        },
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: AppColors.lightGreen,
                title: Text(
                  StringApp.cart,
                  maxLines: 1,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.orangeryYellow,
                  ),
                ),
                titleSpacing: 0,
                bottom: PreferredSize(
                  preferredSize: _tabBar.preferredSize,
                  child: ColoredBox(
                    color: Colors.white,
                    child: _tabBar,
                  ),
                ),
                leading: IconButtonRounded(
                  spaceLeft: true,
                  showDecoration: false,
                  customWidget: IconInside(
                      iconCustom: const Icon(Icons.arrow_back_ios_rounded),
                      onClick: () {
                        exitPage();
                      }),
                ),
              ),
              body: TabBarView(
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  const InCartPage(),
                  Container(),
                  Container(),
                  Container(),
                ],
              )),
        ),
      ),
    );
  }
}

class ModelCheckBox {
  dynamic title;
  bool isChecked;

  ModelCheckBox(this.title, this.isChecked);
}

class ListModelCheckBox {
  List<ModelCheckBox> listModelCheckBoxs;
  bool isChecked;

  ListModelCheckBox(this.listModelCheckBoxs, this.isChecked);
}
