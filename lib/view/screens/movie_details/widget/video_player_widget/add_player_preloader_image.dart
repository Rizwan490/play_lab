import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import '../../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class PlayerPreLoaderImage extends StatelessWidget {
  final VoidCallback? press;
  final bool fromLiveTv;
  final String image;

  const PlayerPreLoaderImage({
    super.key,
    this.fromLiveTv = true,
    this.press,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: CustomNetworkImage(sliderOverlay:true,showErrorImage:false,height:200,width: MediaQuery.of(context).size.width - 20,imageUrl: image,showPlaceHolder: false,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 15,
             ),
              child: GestureDetector(
                  onTap:fromLiveTv? () {
                    Get.back();
                  }:press,
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
