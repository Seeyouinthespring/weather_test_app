import 'package:flutter/material.dart';

class CustomTextHeader extends StatelessWidget{
  final String text;

  const CustomTextHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
