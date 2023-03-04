import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  AppInput(
      {required this.hintText,
      this.isPassword = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
