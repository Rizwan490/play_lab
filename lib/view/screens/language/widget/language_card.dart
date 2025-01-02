import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/util.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/components/small_text.dart';

import '../../../../core/utils/my_color.dart';

class LanguageCard extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final bool isShowTopRight;
  final String langeName;
  final String imagePath;

  const LanguageCard({super.key, required this.index, required this.selectedIndex, this.isShowTopRight = false, required this.langeName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    print(imagePath);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.space20 + 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(Dimensions.cardRadius), boxShadow: MyUtil.getShadow(), border: Border.all(color: MyColor.borderColor, width: .5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              MyImageWidget(
                imageUrl: imagePath,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: Dimensions.space10),
              SmallText(
                text: langeName.tr,
                textStyle: regularSmall.copyWith(color: MyColor.getTextColor()),
              )
            ],
          ),
        ),
        index == selectedIndex
            ? isShowTopRight
                ? Positioned(
                    right: Dimensions.space12,
                    top: Dimensions.space10,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: MyColor.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: MyColor.colorWhite, size: 10),
                    ),
                  )
                : Positioned(
                    left: 50,
                    right: 50,
                    top: 25,
                    child: Container(
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColor.primaryColor.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: MyColor.colorWhite, size: 22.5),
                    ),
                  )
            : const Positioned(
                top: Dimensions.space10,
                right: Dimensions.space12,
                child: SizedBox(),
              )
      ],
    );
  }
}
