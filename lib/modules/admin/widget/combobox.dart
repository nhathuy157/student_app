import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../service/size_screen.dart';

class ComboboxAddJob extends StatefulWidget {
  final String textAddJob;
  const ComboboxAddJob({Key? key, required this.textAddJob}) : super(key: key);

  @override
  State<ComboboxAddJob> createState() => _ComboboxAddJobState();
}

class _ComboboxAddJobState extends State<ComboboxAddJob> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 6, bottom: 4, left: 4),
            child: Text(
              widget.textAddJob,
              style: AppTextStyles.h5
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: SizeScreen.sizeWidthScreen * 1.3 / 10,
              width: SizeScreen.sizeWidthScreen * 6 / 10,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.lightGreen, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(''),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
