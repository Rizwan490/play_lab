import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/styles.dart';
import '../../../../../core/utils/my_color.dart';

class CustomRow extends StatelessWidget {

  const CustomRow({
    super.key,
    required this.firstText,
    required this.lastText,
    this.imageSrc,
    this.showDivider = true,
    this.showImage = false,
  });

  final String firstText,lastText;
  final bool showDivider;
  final bool showImage;
  final String? imageSrc;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child:Text(firstText.tr, style: mulishRegular.copyWith(color: MyColor.textColor),overflow: TextOverflow.ellipsis,maxLines: 1,)),
        Flexible(child:Text(lastText, maxLines:2, style: mulishRegular.copyWith(color: MyColor.t1),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))
      ],
    );
  }
}