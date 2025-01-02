import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/rent/rent_controller.dart';
import 'package:play_lab/data/repo/rent/rent_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/screens/rent/widget/loading_items.dart';

class RentItemListScreen extends StatefulWidget {
  const RentItemListScreen({super.key});

  @override
  State<RentItemListScreen> createState() => _RentItemListScreenState();
}

class _RentItemListScreenState extends State<RentItemListScreen> {
  ScrollController scrollController = ScrollController();
  //
  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<RentController>().hasNext()) {
        Get.find<RentController>().getRentedVideoList();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RentRepo(apiClient: Get.find()));
    final controller = Get.put(RentController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.secondaryColor,
      appBar: CustomAppBar(title: MyStrings.rentedItems.tr),
      body: GetBuilder<RentController>(
        builder: (controller) {
          return RefreshIndicator(
            backgroundColor: MyColor.cardBg,
            color: MyColor.primaryColor,
            onRefresh: () async {
              controller.initialValue();
            },
            child: Padding(
              padding: Dimensions.padding,
              child: controller.isLoading
                  ? ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return LoadingItems();
                      },
                    )
                  : (!controller.isLoading && controller.items.isEmpty)
                      ? const NoDataFoundScreen()
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: Dimensions.space10);
                          },
                          itemCount: controller.items.length + 1,
                          itemBuilder: (context, index) {
                            if (controller.items.length == index) {
                              return controller.hasNext()
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const SizedBox();
                            }
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [int.tryParse(controller.items[index].item?.id.toString() ?? '-1'), -1]);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space10),
                                decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    MyImageWidget(
                                      radius: 8,
                                      imageUrl: '${UrlContainer.baseUrl}${controller.landScapePath}/${controller.items[index].item?.image?.landscape}',
                                    ),
                                    const SizedBox(width: Dimensions.space10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.items[index].item?.title ?? '',
                                            style: mulishBold.copyWith(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            controller.items[index].item?.description ?? '',
                                            style: mulishLight.copyWith(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    controller.items[index].item?.ratings ?? '',
                                                    style: mulishRegular.copyWith(color: MyColor.highPriorityPurpleColor),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '|',
                                                style: mulishSemiBold.copyWith(color: MyColor.bodyTextColor),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.remove_red_eye,
                                                    color: MyColor.primaryColor,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    controller.items[index].item?.view ?? '',
                                                    style: mulishRegular.copyWith(color: MyColor.highPriorityPurpleColor),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().scale(
                                    delay: (100 * index).ms,
                                    duration: (index * 100).ms,
                                  ),
                            );
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}
