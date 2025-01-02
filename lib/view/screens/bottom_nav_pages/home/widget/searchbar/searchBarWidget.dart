import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/view/components/auth_image.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/custom_text_field.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';

import '../../../../../../data/controller/home/home_controller.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextField(
                fillColor: MyColor.bgColor,
                isShowSuffixIcon: true,
                isSearch: true,
                borderRadius: 8,
                isIcon: true,
                controller: controller.searchController,
                suffixIconUrl: "",
                onSuffixTap: () {
                  setState(() {
                    isExpanded = false;
                  });
                  FocusScope.of(context).unfocus();
                  if (controller.searchController.text.isNotEmpty) {
                    String searchText = controller.searchController.text;
                    Get.toNamed(RouteHelper.searchScreen, arguments: searchText);
                    controller.searchController.clear();
                  }
                },
                hintText: MyStrings.search,
                onChanged: (value) {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(
    BuildContext context, {
    required String urlImage,
    required String name,
    required bool isSubscribed,
    bool isGuest = false,
  }) =>
      Column(
        children: [
          isGuest
              ? const AuthImageWidget()
              : Row(
                  children: [
                    urlImage.isEmpty
                        ? const CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(MyImages.profile),
                          )
                        : Container(
                            decoration: BoxDecoration(border: Border.all(color: MyColor.colorWhite), shape: BoxShape.circle),
                            child: MyImageWidget(
                              imageUrl: '${UrlContainer.baseUrl}/assets/images/user/profile/$urlImage',
                              isProfile: true,
                              height: 40,
                              width: 40,
                              radius: 50,
                            ),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isSubscribed) ...[
                          CategoryButton(
                            text: MyStrings.subscribed,
                            press: () {},
                          )
                        ] else ...[
                          CategoryButton(
                            text: MyStrings.subscribeNow,
                            press: () {
                              Get.toNamed(RouteHelper.subscribeScreen);
                            },
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
        ],
      );
}
