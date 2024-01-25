import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() ontap;
  final String text;
  final Color color;

  const MyButton(
      {super.key,
      required this.ontap,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          )),
        ),
      ),
    );
  }
}
