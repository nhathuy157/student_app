// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ItemBanner extends StatelessWidget {
  final String images;

  const ItemBanner({required this.images});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(images),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
