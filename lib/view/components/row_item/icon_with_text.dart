import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';

class IconWithText extends StatelessWidget {

  final IconData icon;
  final String text;
  final bool isRating;
  final double iconSize;
  final double textSize;
  final double iconSpace;
  final Color textColor;

  const IconWithText({super.key,
    this.textColor = MyColor.colorWhite,
    this.iconSpace = 5,
    this.textSize=Dimensions.fontSmall,
    this.iconSize=16,
    this.isRating=true,
    required this.icon,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: isRating?Colors.yellow:MyColor.primaryColor,size: iconSize,),
        SizedBox(width: iconSpace),
        Text(text.tr,style: mulishSemiBold.copyWith(fontSize:textSize,color: textColor),overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
