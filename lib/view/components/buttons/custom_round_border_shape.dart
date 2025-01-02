import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';

class RoundedBorderContainer extends StatelessWidget {
  const RoundedBorderContainer({
    super.key,
    required this.text,
    this.borderColor = MyColor.primaryColor,
    this.bgColor,
    this.textColor = MyColor.primaryColor,
    this.verticalPadding = 5,
    this.horizontalPadding = 12,
  });

  final Color textColor, borderColor;
  final Color? bgColor;
  final String text;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: bgColor ?? MyColor.primaryColor500,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Text(
        text.tr,
        style: mulishBold.copyWith(color: textColor, fontSize: Dimensions.fontSmall),
      ),
    );
  }
}
