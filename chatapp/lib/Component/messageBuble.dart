import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  final String message;
  final Color color;
  final double margin;
  const MessageBuble({super.key, required this.message, required this.color, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(margin),
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        constraints: const BoxConstraints(maxWidth: 300),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(microseconds: 1500),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
