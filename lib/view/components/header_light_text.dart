
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class HeaderLightText extends StatelessWidget {
  const HeaderLightText({super.key,required this.text,this.textColor=MyColor.colorWhite,this.showCustomColor=false });
  final String text;
  final Color textColor;
  final bool showCustomColor;

  @override
  Widget build(BuildContext context) {
    return Text(text.tr,style:mulishLight.copyWith(color: textColor,fontSize: Dimensions.fontLarge),overflow: TextOverflow.ellipsis,);
  }
}
