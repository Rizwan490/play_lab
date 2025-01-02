import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import '../../../constants/my_strings.dart';

class ShowMoreText extends StatelessWidget {
  final String text;
  final Callback onTap;

  const ShowMoreText({super.key, required this.onTap, this.text = MyStrings.showMore});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text.tr,
        style: mulishSemiBold.copyWith(
          color: MyColor.primaryColor,
          decoration: TextDecoration.underline,
          decorationColor: MyColor.primaryColor,
        ),
      ),
    );
  }
}
