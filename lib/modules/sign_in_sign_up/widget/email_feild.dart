import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: 'Email',
              border: InputBorder.none,
              suffixIcon: widget.controller.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      onPressed: () {
                        widget.controller.clear();
                      },
                      icon: const Icon(Icons.close))),
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Enter a valid email'
              : null,
        ),
      ],
    );
  }
}
