import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class LabelText extends StatelessWidget {
  const LabelText({super.key,required this.text,this.size=Dimensions.fontLarge,this.space=8,this.bottom=8});
  final String text;
  final double size;
  final double space;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: space,),
        Text(text.tr,style: mulishBold.copyWith(fontSize: size,color: Colors.white),),
        SizedBox(height: bottom,),
      ],
    );
  }
}
