import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class DismissiblePageCustom extends StatelessWidget {
  final Widget child;
  final VoidCallback function;
  const DismissiblePageCustom({
    Key? key,
    required this.child,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      direction: DismissiblePageDismissDirection.startToEnd,
      startingOpacity: 0.2,
      onDismissed: function,
      child: child,
    );
  }
}
