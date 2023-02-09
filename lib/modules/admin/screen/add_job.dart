import 'package:flutter/material.dart';
import 'package:student_app/modules/admin/widget/combobox.dart';

import 'package:student_app/modules/admin/widget/textbox.dart';
import 'package:student_app/modules/admin/widget/textbox_%20description.dart';
import 'package:student_app/modules/admin/widget/textbox_and_combobox.dart';
import 'package:student_app/modules/admin/widget/textbox_img.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../../../widgets/stateless/icon_inside.dart';
import '../widget/dropdown_natural.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thêm công việc',
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
            TextBoxWidget(
              textAddJob: 'Tên nơi làm việc *',
            ),
            TextBoxWidget(
              textAddJob: 'Tên công việc *',
            ),
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
            ComboboxAddJob(
              textAddJob: 'Lĩnh vực',
            ),
            DropDownWidget(),
            TextBoxImgWidget(),
            TextBoxWidget(textAddJob: 'Địa chỉ *'),
            TextBoxAndComboBoxWidget(),
            TextBoxDescriptionWidget(textAddJob: 'Mô tả công việc'),
            TextBoxDescriptionWidget(textAddJob: 'Quyền lơi'),
            TextBoxDescriptionWidget(textAddJob: 'Liên hệ'),
            TextBoxWidget(textAddJob: 'Liên hệ *')
          ],
        ),
      ),
    );
  }
}
