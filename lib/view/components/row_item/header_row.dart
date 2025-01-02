import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';
import '../text/show_more_text.dart';

class HeaderRow extends StatelessWidget {
  final String heading;
  final Callback onShowMorePress;
  final IconData icon;
  final bool isShowMoreVisible;
  const HeaderRow({super.key,this.isShowMoreVisible=true,this.icon=Icons.play_arrow_outlined,required this.heading,required this.onShowMorePress});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon,color: MyColor.primaryColor,size: 20,),
            const SizedBox(width: 10,),
            Text(heading.tr,style: mulishSemiBold.copyWith(fontSize:Dimensions.fontLarge,color: Colors.white,),)
          ],
        ),
        isShowMoreVisible?GestureDetector(onTap: (){

        },child:ShowMoreText(onTap: onShowMorePress,)):const SizedBox.shrink(),
      ],
    );
  }
}
