import 'package:flutter/material.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';

class SubscribeOrWatch extends StatelessWidget {
  final String url;
  final bool watch, isLoading;
  const SubscribeOrWatch({
    super.key,
    required this.url,
    required this.watch,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 9 / 9,
            child: Opacity(opacity: 0.4, child: MyImageWidget(imageUrl: url, width: double.infinity)),
          ),
          Positioned(
            left: 5,
            top: 10,
            child: IconButton(
              onPressed: () async {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: MyColor.colorWhite,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: isLoading
                  ? const CustomLoader(isPagination: true)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          watch ? Icons.play_circle : Icons.lock_outline,
                          color: MyColor.primaryColor,
                          size: 50,
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Text(watch ? MyStrings.watchNow : MyStrings.subscribeNow.tr.toUpperCase(), style: mulishRegular.copyWith(color: MyColor.colorWhite)),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
