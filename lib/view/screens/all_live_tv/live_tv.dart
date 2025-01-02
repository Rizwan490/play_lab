import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:play_lab/view/screens/all_live_tv/widget/all_live_tv_shimmer/all_live_tv_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/live_tv_controller/live_tv_controller.dart';
import 'package:play_lab/data/repo/live_tv_repo/live_tv_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/all_live_tv/widget/live_tv_grid_item/live_tv_grid_item.dart';

import '../../../constants/my_strings.dart';
import '../../../core/utils/url_container.dart';

class AllLiveTvScreen extends StatefulWidget {
  const AllLiveTvScreen({super.key});

  @override
  State<AllLiveTvScreen> createState() => _AllLiveTvScreenState();
}

class _AllLiveTvScreenState extends State<AllLiveTvScreen> {
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<LiveTvController>().hasNext()) {
        Get.find<LiveTvController>().getPaginateTV();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LiveTvRepo(apiClient: Get.find()));
    final liveTvController = Get.put(LiveTvController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      liveTvController.loadData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveTvController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.colorBlack,
        appBar: const CustomAppBar(title: MyStrings.allTV),
        body: controller.isLoading
            ? const AllLiveTvShimmer()
            : Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ListView.builder(
                  itemCount: controller.televisionList.length,
                  itemBuilder: (context, index) {
                    final telivision = controller.televisionList[index];
                    final channelList = telivision.channels ?? [];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
                      decoration: const BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${telivision.name} Channels ', style: mulishBold.copyWith()),
                              if (!controller.subcribeChannelList.contains(telivision.id.toString())) ...[
                                CategoryButton(
                                  text: controller.isSubcribeLoading == telivision.id.toString() ? 'Loading..' : MyStrings.subscribeNow,
                                  press: () {
                                    if (controller.repo.apiClient.isAuthorizeUser()) {
                                      AppDialog().subcribcritionAlert(
                                        context,
                                        () {
                                          controller.subcribeNow(telivision);
                                        },
                                        msgText: "Are you sure to subscribe to this channel group?\nMonthly subscription price is ${controller.currencySym}${StringConverter.roundDoubleAndRemoveTrailingZero(telivision.price ?? '0')} ${controller.currency}",
                                      );
                                    } else {
                                      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.plsLoginAndSubscribeToWatch], msg: [], isError: true);
                                    }
                                  },
                                )
                              ]
                            ],
                          ),
                          const SizedBox(height: Dimensions.space20),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            children: List.generate(channelList.length, (i) {
                              return LiveTvGridItem(
                                liveTvName: channelList[i].title ?? '',
                                imageUrl: '${UrlContainer.baseUrl}${controller.televisionImagePath}/${channelList[i].image}',
                                press: () {
                                  if (controller.repo.apiClient.isAuthorizeUser()) {
                                    if (controller.subcribeChannelList.contains(telivision.id.toString())) {
                                      Get.toNamed(RouteHelper.liveTvDetailsScreen, arguments: channelList[i].id);
                                    } else {
                                      CustomSnackbar.showCustomSnackbar(errorList: ["Please Subcribe to watch"], msg: [], isError: true);
                                    }
                                  } else {
                                    showLoginDialog(context);
                                  }
                                },
                              );
                            }),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
