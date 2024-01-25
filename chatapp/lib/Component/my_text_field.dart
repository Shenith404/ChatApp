import 'package:chatapp/Component/colors.dart';
import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController contraller;
  final String hintText;
  final bool obscureText;
  const MyTextfield(
      {super.key,
      required this.contraller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextField(
        cursorColor: Colors.black,
        controller: contraller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromRGBO(185, 184, 184, 1)),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.defaultColor2),
              borderRadius: BorderRadius.circular(10)),
          hintText: hintText,
        ),
      ),
    );
  }
}
