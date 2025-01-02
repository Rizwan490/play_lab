
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

import '../../core/utils/my_color.dart';
class CustomBackSupportAppBar extends StatelessWidget {

 final VoidCallback press;
 final VoidCallback? press2;
 final bool isShowActionBtn;
 final bool showTitle;
 final Color backBtnBgColor;
 final Color backBtnIconColor;
 final String title;
 final bool showActionIconInStart;

const CustomBackSupportAppBar({
  super.key,
  this.showTitle=true,
  this.showActionIconInStart=false,
  this.title='',
  this.backBtnIconColor=MyColor.colorWhite,
  this.backBtnBgColor=Colors.transparent,
  required this.press,
  this.isShowActionBtn=false,
  this.press2
});

  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
          padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: backBtnBgColor, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          backgroundColor: backBtnBgColor,
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: IconButton(
                          icon:  Icon(Icons.arrow_back,color: backBtnIconColor,),
                          onPressed: press,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(title.tr,style: mulishSemiBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorWhite),),
                    const Spacer(),
                   const SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}