import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';

import '../../core/utils/my_images.dart';
import '../../core/utils/styles.dart';

class SpaceBetweenRow extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback? press1;
  final VoidCallback? press2;
  final bool isShowDetailsBG;
  final Color text1Color, text2Color;
  final bool isFirstTextBold;
  final bool isSecondTextBold;
  final bool isShowBorder;
  final bool isSecondIcon;

  const SpaceBetweenRow({super.key, this.isShowBorder = false, this.isFirstTextBold = false, this.isShowDetailsBG = false, required this.text1, required this.text2, this.press1, this.press2, this.isSecondTextBold = false, this.isSecondIcon = false, this.text1Color = MyColor.colorBlack, this.text2Color = MyColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
            child: Text(
          text1.tr,
          style: isFirstTextBold ? mulishSemiBold.copyWith(color: text1Color) : mulishLight.copyWith(color: text1Color),
        )),
        GestureDetector(
          onTap: press2,
          child: isSecondIcon
              ? SvgPicture.asset(
                  MyImages.menuSvgIcon,
                  height: 20,
                  width: 30,
                  colorFilter: const ColorFilter.mode(MyColor.primaryColor, BlendMode.srcIn),
                )
              : isShowDetailsBG
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(border: Border.all(color: MyColor.primaryColor, width: isShowBorder ? 1 : 0), borderRadius: BorderRadius.circular(4), color: MyColor.primaryColor900),
                      child: Text(
                        text2.tr,
                        style: mulishRegular.copyWith(color: MyColor.primaryColor),
                      ),
                    )
                  : Text(
                      text2.tr,
                      style: isSecondTextBold ? mulishBold.copyWith(color: text2Color, fontSize: Dimensions.fontDefault) : mulishRegular.copyWith(color: text2Color),
                    ),
        )
      ],
    );
  }
}
