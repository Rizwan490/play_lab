import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';

class TeamRow extends StatelessWidget {
  final String firstText;
  final String secondText;
  const TeamRow({super.key,required this.firstText,required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(firstText.tr,style: mulishSemiBold.copyWith(color: MyColor.colorWhite),),
        const SizedBox(width:5),
        Flexible(child: Text(secondText.tr,maxLines:5,style: mulishLight.copyWith(color: MyColor.colorWhite),)),
      ],
    );
  }
}
