import 'package:flutter/material.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';

import '../../../config/themes/app_colors.dart';
import '../../../service/size_screen.dart';

class IconButtonCart extends StatefulWidget {
  bool showDecoration = true;
   IconButtonCart({Key? key, this.showDecoration = true})
      : super(key: key);

  @override
  State<IconButtonCart> createState() => _IconButtonCartState();
}

class _IconButtonCartState extends State<IconButtonCart> {
  double space = SizeScreen.sizeSpace;
  int cartValue = 2;
  @override
  Widget build(BuildContext context) {
    final deltaFontSize = (cartValue.toString().length - 1) * 2.0;
    return IconButtonRounded(
      showDecoration: widget.showDecoration,
      customWidget: Stack(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.shopping_cart_outlined),
            iconSize: SizeScreen.sizeIcon + space / 2,
            color: AppColors.blue,
            onPressed: () {},
          ),
          Positioned(
              right: SizeScreen.sizeSpace / 4,
              top: SizeScreen.sizeSpace / 4,
              child: CircleAvatar(
                backgroundColor: AppColors.orangeryYellow,
                radius: 8,
                child: Text(
                  cartValue.toString(),
                  style: TextStyle(
                      fontSize: 8 - deltaFontSize, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
