import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:get/get.dart';

class MovieDetailsCard extends StatelessWidget {
  final String title, subtitle;
  const MovieDetailsCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space8),
      decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.play_arrow_outlined, color: MyColor.primaryColor),
              Text(
                title.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
              ),
            ],
          ),
          Text(
            subtitle.tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
          ),
        ],
      ),
    );
  }
}
