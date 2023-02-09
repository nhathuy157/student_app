import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../service/size_screen.dart';

class DropDownMotel extends StatefulWidget {
  const DropDownMotel({Key? key}) : super(key: key);

  @override
  State<DropDownMotel> createState() => _DropDownMotelState();
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

class _DropDownMotelState extends State<DropDownMotel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 6,
              bottom: 4,
            ),
            child: Text(
              'Loại chỗ ở ',
              style: AppTextStyles.h5
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: SizeScreen.sizeWidthScreen * 1.5 / 10,
            width: SizeScreen.sizeWidthScreen * 5.9 / 10,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)
              ],
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: AppColors.lightGreen)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: AppColors.lightGreen))),
              value: selectedItem,
              onChanged: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
              items: itemTest
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
