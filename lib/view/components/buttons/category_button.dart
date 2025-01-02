import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';

import '../../../core/utils/my_color.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double textSize;
  const CategoryButton({
    super.key,
    required this.text,
    this.horizontalPadding=3,
    this.verticalPadding=3,
    this.textSize=Dimensions.fontExtraSmall,
    required this.press,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color
          ),
          child: Text(text,style: mulishRegular.copyWith(fontSize:textSize,color: textColor),),
        )
      ),
    );
  }

}