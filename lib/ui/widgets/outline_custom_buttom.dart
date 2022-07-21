import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedButton(
      {Key? key,
      this.onPressed,
      required this.text,
      this.color = Colors.blue,
      this.isFilled = false,
      this.isTextWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStateProperty.all(BorderSide(color: color)),
          backgroundColor: MaterialStateProperty.all(
              isFilled ? color.withOpacity(0.3) : Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: isTextWhite ? Colors.white : color),
        ));
  }
}
