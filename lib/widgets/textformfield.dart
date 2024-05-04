import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int length;
  final FormFieldValidator<String> validator;

  const CustomText(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.length,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: length,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      validator: validator,
    );
  }
}
