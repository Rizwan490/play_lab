import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/url_container.dart';
import '../../../../../../data/controller/home/home_controller.dart';
import '../../../../../components/custom_sized_box.dart';
import '../../../../../components/buttons/category_button.dart';
import '../../../../../components/row_item/icon_with_text.dart';
import '../../shimmer/banner_shimmer.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  void initState() {
    super.initState();
  }

  int currentPageIndex = 0;

  void changeCurrentPageIndex(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => controller.sliderLoading
          ? const BannerShimmer()
          : Column(
              children: [
                SizedBox(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, i) {
                        changeCurrentPageIndex(index);
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                    items: controller.sliderList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 170,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [int.parse(i.itemId.toString()), -1]);
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: MyImageWidget(
                                        height: 170,
                                        imageUrl: '${UrlContainer.baseUrl}${controller.sliderImagePath}${i.item?.image?.landscape}',
                                      ),
                                      
                                    ),
                                  ),
                                  i.captionShow.toString() == '0'
                                      ? const SizedBox()
                                      : Positioned(
                                          bottom: 0,
                                          left: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CategoryButton(text: '${i.item?.title}', press: () {}),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    IconWithText(
                                                      icon: Icons.star,
                                                      text: i.item?.ratings ?? '',
                                                      isRating: true,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    IconWithText(
                                                      icon: Icons.remove_red_eye,
                                                      text: i.item?.ratings ?? '',
                                                      isRating: false,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                const CustomSizedBox(),
                Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    controller.sliderList.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: index == currentPageIndex ? MyColor.primaryColor : Colors.transparent, border: Border.all(color: MyColor.primaryColor, width: 1)),
                    ),
                  ),
                )),
              ],
            ),
    );
  }
}
