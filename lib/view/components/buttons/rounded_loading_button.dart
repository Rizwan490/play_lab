import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';

import '../../../core/utils/my_color.dart';

class RoundedLoadingButton extends StatelessWidget {
  final Color color, textColor;
  final double width;
  final double hPadding;
  final double vPadding;
  final double vRadius;

  const RoundedLoadingButton({
    super.key,
    this.width = 1,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
    this.hPadding = 35,
    this.vPadding = 15,
    this.vRadius = Dimensions.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: MyColor.transparentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(vRadius)),
          padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
          textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: textColor, strokeWidth: 2),
        ),
      ),
    );
  }
}
