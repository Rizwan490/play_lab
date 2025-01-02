import 'package:flutter/material.dart';
import '../../core/utils/styles.dart';

import '../../core/utils/my_color.dart';


class TextFieldContainer2 extends StatelessWidget {

  final Widget child;
  final VoidCallback onTap;
  final Color fillColor;
  final bool isShowSuffixView;

  final String? prefixWidgetValue;

  const TextFieldContainer2({
    super.key,
    required this.child,
    this.fillColor=MyColor.textFieldColor,
    required this.onTap,
    this.isShowSuffixView = false,
    this.prefixWidgetValue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: isShowSuffixView ?
        IntrinsicHeight(
          child: Row(
            children: [
           Container(
            height: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
            decoration: const BoxDecoration(
             borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomLeft:Radius.circular(4) ),
               color: MyColor.primaryColor),
            child: Text(prefixWidgetValue??'',
              style: mulishBold.copyWith(color: MyColor.colorWhite),),
          ),Expanded(child: child)],),
        ):child,
      ),
    );
  }
}
