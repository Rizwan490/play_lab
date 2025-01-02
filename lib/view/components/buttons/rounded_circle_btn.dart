import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_color.dart';


class RoundedCircleButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  const RoundedCircleButton({
    super.key,
    required this.text,
    required this.press,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
  }) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
      child: Text(
        text.tr,
        style: TextStyle(color: textColor),
      ),
    );
  }
}