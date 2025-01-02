import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/row_item/icon_with_text.dart';


class RatingAndWatchWidget extends StatelessWidget {

  final String watch;
  final String rating;
  final double iconSize;
  final double textSize;
  final double iconSpace;
  final Color textColor;

  const RatingAndWatchWidget({
    super.key,
    this.textColor = MyColor.colorWhite,
    this.iconSpace = 5,
    required this.watch,
    required this.rating,
    this.iconSize=16,
    this.textSize=Dimensions.fontSmall
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWithText(textColor:textColor,iconSpace:iconSpace,icon: Icons.star, text: rating.toString(),iconSize: iconSize,textSize: textSize,),
        SizedBox(width: iconSpace,),
        Text('|',style: mulishSemiBold.copyWith(color: MyColor.bodyTextColor),),
        SizedBox(width: iconSpace,),
        IconWithText(iconSpace:iconSpace,textColor:textColor,icon: Icons.remove_red_eye,isRating: false, text: watch,iconSize: iconSize,textSize: textSize,)
      ],
    );
  }
}
