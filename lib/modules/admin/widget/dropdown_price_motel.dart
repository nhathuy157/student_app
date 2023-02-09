import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';

import '../../../service/size_screen.dart';

class DropDownCategorySalaryMotel extends StatefulWidget {
  const DropDownCategorySalaryMotel({Key? key}) : super(key: key);

  @override
  State<DropDownCategorySalaryMotel> createState() =>
      _DropDownCategorySalaryMotelState();
}

List<String> itemTest = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
  'Item 6',
];
String? selectedItem = 'Item 1';

class _DropDownCategorySalaryMotelState
    extends State<DropDownCategorySalaryMotel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeScreen.sizeWidthScreen * 1.5 / 10,
      width: SizeScreen.sizeWidthScreen * 3.5 / 10,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: AppColors.lightGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: AppColors.lightGreen),
            )),
        value: selectedItem,
        onChanged: (item) {
          setState(() {
            selectedItem = item;
          });
        },
        items: itemTest
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
      ),
    );
  }
}
