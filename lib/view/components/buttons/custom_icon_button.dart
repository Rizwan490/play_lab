

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:play_lab/core/utils/my_color.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback press;
  final Color iconColor;
  final bool isLoading;
  const CustomIconButton({super.key,this.isLoading=false,this.iconColor=MyColor.primaryColor,required this.icon,required this.press});

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        padding:const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.colorWhite
        ),
        child: widget.isLoading?const SizedBox(height:25,width:25, child: SpinKitFadingCircle(size: 20,color: MyColor.primaryColor,)):Icon(widget.icon,color: widget.iconColor),
      ),
    );
  }
}
