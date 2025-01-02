
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/utils/styles.dart';


class SmallText extends StatelessWidget {

  final String text;
  final TextStyle textStyle;

  const SmallText({
    super.key,
    required this.text,
    this.textStyle=mulishLight
  });



  @override
  Widget build(BuildContext context) {
    return Text(text.tr,style: textStyle);
  }
}


