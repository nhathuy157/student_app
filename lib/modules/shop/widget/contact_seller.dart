import 'package:flutter/material.dart';

class ContactSeller extends StatefulWidget {
  const ContactSeller({Key? key, this.haveCheckBox = false}) : super(key: key);
  final bool haveCheckBox;
  @override
  State<ContactSeller> createState() => _ContactSellerState();
}

class _ContactSellerState extends State<ContactSeller> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.haveCheckBox ? Container() : buildCheckBox(),
      ],
    );
  }

  Widget buildCheckBox() => Checkbox(
      value: isCheck,
      onChanged: (isCheck) {
        setState(() {
          this.isCheck = !this.isCheck;
        });
      });
}
