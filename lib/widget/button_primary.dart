import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onTap;

  ButtonPrimary({required this.text, this.onTap, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: color != null ? color : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
