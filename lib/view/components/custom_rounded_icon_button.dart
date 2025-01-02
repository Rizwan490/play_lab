import 'package:flutter/material.dart';

import '../../core/utils/my_color.dart';

class CustomRoundedIconButton extends StatelessWidget {
  final VoidCallback press;
  final Color color, textColor;
  final double verticalPadding;
  final IconData icon;
  final double horizontalPadding;
  final double horizontalMargin;
  final double verticalMargin;
  final Color iconColor;
  final bool isCircle;
  final double radius;

  const CustomRoundedIconButton({super.key, required this.press, this.color = MyColor.primaryColor, this.textColor = Colors.white, this.horizontalPadding = 8, this.verticalPadding = 8, this.horizontalMargin = 0, this.icon = Icons.clear, this.iconColor = MyColor.red, this.isCircle = true, this.radius = 12, this.verticalMargin = 0});

  @override
  Widget build(BuildContext context) {
    return isCircle
        ? GestureDetector(
            onTap: press,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalMargin),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor,
                )),
          )
        : GestureDetector(
            onTap: press,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalMargin),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: color),
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor,
                )),
          );
  }
}
