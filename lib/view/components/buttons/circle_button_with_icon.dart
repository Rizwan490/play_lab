import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import '../../../core/utils/my_color.dart';
import '../../screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Callback press;
  final double padding;
  final String imageUrl;
  final Color bg;
  final bool isIcon;
  final bool isTextHide;
  final bool fromAsset;
  final double circleSize;
  final double imageSize;
  final String text;
  final Color textColor;

  const SocialLoginButton({
    super.key,
    this.imageUrl = '',
    this.fromAsset = false,
    this.circleSize = 25,
    this.imageSize = 25,
    this.isIcon = true,
    this.isTextHide = false,
    this.bg = MyColor.textFieldColor,
    this.padding = 5,
    this.text = '',
    required this.press,
    this.textColor = MyColor.colorWhite,
    this.icon = Icons.clear,
  });

  @override
  Widget build(BuildContext context) {
    return isIcon
        ? GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(padding),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: bg),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: MyColor.colorWhite,
                    size: 20,
                  ),
                  Text(
                    text,
                    style: mulishRegular.copyWith(color: textColor, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Dimensions.radius - 4)),
              child: Row(
                children: [
                  fromAsset
                      ? Image.asset(
                          imageUrl,
                          width: imageSize,
                          height: imageSize,
                        )
                      : CustomNetworkImage(
                          imageUrl: imageUrl,
                          height: imageSize,
                          width: imageSize,
                        ),
                  if (isTextHide == false) ...[
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: mulishRegular.copyWith(color: textColor, fontWeight: FontWeight.w600),
                    )
                  ],
                ],
              ),
            ),
          );
  }
}
