import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class BannerShimmer extends StatefulWidget {
  const BannerShimmer({super.key});

  @override
  State<BannerShimmer> createState() => _BannerShimmerState();
}

class _BannerShimmerState extends State<BannerShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150.0,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, i) {

          },
          scrollDirection: Axis.horizontal,
        ),
        items: [1,2,3].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Shimmer.fromColors(
                baseColor: MyColor.shimmerBaseColor,
                highlightColor: MyColor.shimmerSplashColor,
                child: SizedBox(
                  height: 170,
                  child: Stack(
                    children: [
                      Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: MyColor.textFieldColor
                       ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                        ),
                      ),
                      //  Positioned(bottom:0,left:0,right: 0,child: Align(alignment: Alignment.bottomCenter,child:  Row(mainAxisSize:MainAxisSize.min,children:List.generate(5, (index) =>Container(margin:EdgeInsets.all(3),padding:EdgeInsets.all(4),decoration: BoxDecoration(shape: BoxShape.circle,color: index+1==i?ColorResources.primaryColor:Colors.transparent,border: Border.all(color: ColorResources.primaryColor,width: 1)),))))),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
