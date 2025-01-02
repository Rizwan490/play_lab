import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';

class CustomNetworkImage extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final IconData errorImage;
  final BoxFit boxFit;
  final double spinKitSize;
  final int duration;
  final bool isSlider;
  final bool fromSplash;
  final bool sliderOverlay;
  final bool showPlaceHolder;
  final bool showErrorImage;

  const CustomNetworkImage({
    super.key,
    this.height = 110,
    this.width = 320,
    this.fromSplash = false,
    this.duration = 500,
    this.spinKitSize = 30,
    this.isSlider = false,
    this.showPlaceHolder = true,
    this.sliderOverlay = false,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.errorImage = Icons.error_outline_outlined,
    this.showErrorImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return isSlider
        ? CachedNetworkImage(
            height: height,
            colorBlendMode: BlendMode.overlay,
            color: !sliderOverlay ? Colors.transparent : Colors.grey,
            fadeInDuration: Duration(microseconds: duration),
            width: width,
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(image: AssetImage(MyImages.errorImage), fit: BoxFit.cover),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Center(
                  child: SpinKitFadingCube(
                    color: MyColor.primaryColor.withOpacity(0.3),
                    size: Dimensions.space20,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      MyImages.errorImage,
                    ),
                    fit: BoxFit.cover),
              ),
            ), //O
            fit: boxFit,
          )
        : CachedNetworkImage(
            height: height,
            colorBlendMode: BlendMode.overlay,
            color: !sliderOverlay ? Colors.transparent : MyColor.colorGrey,
            fadeInDuration: Duration(microseconds: duration),
            width: width,
            imageUrl: imageUrl,
            placeholder: (context, _) => Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColor.t4,
                image: DecorationImage(image: AssetImage(MyImages.errorImage), fit: BoxFit.cover),
              ),
              child: showPlaceHolder
                  ? Image.asset(
                      MyImages.placeHolderImage,
                      height: 40,
                      width: 40,
                    )
                  : const SizedBox(),
            ),
            errorWidget: (context, url, _) {
              return showErrorImage
                  ? Container(
                      height: height,
                      width: width,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              MyImages.errorImage,
                            ),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Container(
                      height: height,
                      width: width,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              MyImages.errorImage,
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Container(
                        height: height / 3,
                        width: width / 3,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: MyColor.colorBlack,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: MyColor.redCancelTextColor,
                          size: 25,
                        ),
                      ),
                    );
            }, //O
            fit: boxFit,
          );
  }
}
