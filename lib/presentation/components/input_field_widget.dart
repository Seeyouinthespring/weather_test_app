import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget{

  final TextEditingController controller;
  final bool isPasswordHidden;
  final Widget? iconButton;

  const InputFieldWidget({super.key, required this.controller, required this.isPasswordHidden, this.iconButton});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Color(0xFF2B2D33),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xFFE4E6EC), width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xFF0700FF), width: 2),
        ),
        hintText: 'Пароль',
        hintStyle: const TextStyle(
          color: Color(0xFF8799A5),
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: iconButton,
      ),
      obscureText: isPasswordHidden,
    );
  }

}