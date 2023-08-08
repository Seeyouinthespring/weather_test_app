import 'package:flutter/material.dart';

class CustomTextLabel extends StatelessWidget{
  final String text;

  const CustomTextLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
