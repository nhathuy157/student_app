import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/controller/cart_controller.dart';
import 'package:student_app/service/size_screen.dart';

///Counter button class
class CounterMountProduct extends StatefulWidget {
  const CounterMountProduct(
      {Key? key,
      required this.count,
      required this.onChange,
      this.countColor = Colors.black,
      this.addIcon = const Icon(
        Icons.add,
        size: 16,
      ),
      this.removeIcon = const Icon(
        Icons.remove,
        size: 16,
      ),
      this.buttonColor = Colors.black,
      this.progressColor = Colors.black})
      : super(key: key);

  final int count;
  final Color countColor;
  final ValueChanged<int> onChange;
  final Color progressColor;
  final Color buttonColor;
  final Icon addIcon;
  final Icon removeIcon;

  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<CounterMountProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeScreen.sizeBox - SizeScreen.sizeSpace * 2,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.mainColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: SizeScreen.sizeSpace,
                  height: SizeScreen.sizeBox * 2,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        CartController().caculateTotalMoney();
                        widget.onChange(widget.count - 1);
                      });
                    },
                    icon: widget.removeIcon,
                    padding: EdgeInsets.zero,
                    color: widget.buttonColor,
                  ),
                ),
              ),
              const VerticalDivider(
                color: AppColors.mainColor,
                thickness: 1,
                width: 1,
              ),
              Expanded(
                flex: 1,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  layoutBuilder:
                      (Widget? currentChild, List<Widget> previousChildren) {
                    return currentChild!;
                  },
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final Animation<Offset> inAnimation = Tween<Offset>(
                            begin: const Offset(1.0, 0.0), end: Offset.zero)
                        .animate(animation);
                    final Animation<Offset> outAnimation = Tween<Offset>(
                            begin: const Offset(-1.0, 0.0), end: Offset.zero)
                        .animate(animation);

                    if (child.key.toString() == widget.count.toString()) {
                      return ClipRect(
                        child: SlideTransition(
                            position: inAnimation, child: child),
                      );
                    } else {
                      return ClipRect(
                        child: SlideTransition(
                            position: outAnimation, child: child),
                      );
                    }
                  },
                  child: SizedBox(
                    key: Key(widget.count.toString()),
                    width: SizeScreen.sizeBox - 8,
                    height: SizeScreen.sizeBox - 8,
                    child: Center(
                      child: AutoSizeText(widget.count.toString(),
                          style: AppTextStyles.h4.copyWith(
                              color: widget.countColor,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                color: AppColors.mainColor,
                thickness: 1,
                width: 1,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: SizeScreen.sizeSpace,
                  height: SizeScreen.sizeBox - 8,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        CartController().caculateTotalMoney();
                        widget.onChange(widget.count + 1);
                      });
                    },
                    icon: widget.addIcon,
                    padding: EdgeInsets.zero,
                    color: widget.buttonColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
