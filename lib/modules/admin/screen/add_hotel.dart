import 'package:flutter/material.dart';
import 'package:student_app/modules/admin/widget/dropdown_motel.dart';
import 'package:student_app/modules/admin/widget/price_motel.dart';
import 'package:student_app/modules/admin/widget/textbox.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../../../widgets/stateless/icon_inside.dart';
import '../widget/combobox.dart';
import '../widget/textbox_ description.dart';

class AddHotelPage extends StatefulWidget {
  const AddHotelPage({Key? key}) : super(key: key);

  @override
  State<AddHotelPage> createState() => _AddHotelPageState();
}

class _AddHotelPageState extends State<AddHotelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thêm chỗ ở',
          style: AppTextStyles.h2,
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightGreen,
        elevation: 4,
        leading: IconButtonBack(),
        actions: [
          IconButtonRounded(
            customWidget:
                IconInside(iconCustom: Icon(Icons.check), onClick: () {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              color: Colors.red,
            ),
            TextBoxWidget(textAddJob: 'Tên nơi ở *'),
            Container(
              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
              child: Text(
                'Phân loại *',
                textAlign: TextAlign.start,
                style: AppTextStyles.h4.copyWith(
                    color: AppColors.orangeryYellow,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ComboboxAddJob(
              textAddJob: 'Địa điểm',
            ),
            DropDownMotel(),
            TextBoxWidget(textAddJob: 'Địa chỉ *'),
            TextBoxAndComboBoxMotel(),
            TextBoxWidget(textAddJob: 'Diện tích'),
            TextBoxDescriptionWidget(textAddJob: 'Mô tả '),
            TextBoxWidget(textAddJob: 'Liên hệ *')
          ],
        ),
      ),
    );
  }
}
