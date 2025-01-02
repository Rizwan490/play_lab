import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import '../../../core/utils/dimensions.dart';

import '../../../core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double width;
  final double hPadding;
  final double vPadding;
  final double vRadius;
  final bool isLoading;
  const RoundedButton({
    super.key,
    this.width = 1,
    required this.text,
    required this.press,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
    this.hPadding = 23,
    this.vPadding = 15,
    this.vRadius = Dimensions.cornerRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : press,
        style: ElevatedButton.styleFrom(backgroundColor: color, padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding), textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(vRadius))),
        child: isLoading ? const CustomLoader(loaderColor: MyColor.colorWhite) : Text(text.tr, style: TextStyle(color: textColor)),
      ),
    );
  }
}
