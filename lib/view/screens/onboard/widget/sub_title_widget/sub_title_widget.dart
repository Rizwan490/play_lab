import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';

class SubTitleWidget extends StatelessWidget {
  final String text;
  const SubTitleWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          text.tr,
          textAlign: TextAlign.center,
          style: mulishSemiBold.copyWith(
              color: MyColor.colorWhite,
              fontSize: Dimensions.fontDefault),
        ));
  }
}
