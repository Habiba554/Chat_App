import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CustomButton  extends StatelessWidget {
   CustomButton ({super.key, required this.text,
    required this.onPress,
    required this.backColor,
    required this.textColor});
   String?text;
   Color? backColor;
   Color? textColor;
   final Function() onPress;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return  TextButton(
        onPressed: onPress,
        child: Container(
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(8)),
          height: mediaQuery.size.height * 0.06,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.size.height * 0.025,
              ),
            ),
          ),
        ),
      );

  }
}
