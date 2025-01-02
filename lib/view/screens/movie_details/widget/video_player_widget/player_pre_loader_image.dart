import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import '../../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class PlayerPreLoaderImage extends StatelessWidget {
  final VoidCallback? press;
  final bool fromLiveTv;
  final String image;
  final bool isShowLoader;

  const PlayerPreLoaderImage({super.key, this.isShowLoader = false, this.fromLiveTv = true, this.press, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: CustomNetworkImage(sliderOverlay: true, showErrorImage: true, height: 200, width: MediaQuery.of(context).size.width - 20, imageUrl: image, showPlaceHolder: false),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: isShowLoader
                  ? const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: SpinKitFadingCircle(
                          size: 60,
                          color: MyColor.primaryColor,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
          Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 15,
              ),
              child: GestureDetector(
                  onTap: fromLiveTv
                      ? () {
                          Get.back();
                        }
                      : press,
                  child: const Icon(
                    Icons.arrow_back,
                    color: MyColor.colorWhite,
                    size: 20,
                  ))),
        ],
      ),
    );
  }
}
