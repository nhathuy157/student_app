import 'package:flutter/material.dart';

class PageTemp extends StatelessWidget {
  const PageTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Navigator.pop(context, true);
    return Container();
  }
}
