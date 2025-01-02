import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/pusher_controller/pusher_history_helper_controller.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_history_controller.dart';
import 'package:play_lab/data/repo/watch_party/watch_party_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/screens/party/watch_party_history/widgets/join_party_bottom_sheet.dart';
import 'package:play_lab/view/screens/party/watch_party_history/widgets/watch_party_history_card.dart';
import 'package:play_lab/view/screens/rent/widget/loading_items.dart';

class WatchPartyHistoryScreen extends StatefulWidget {
  const WatchPartyHistoryScreen({super.key});

  @override
  State<WatchPartyHistoryScreen> createState() => _WatchPartyHistoryScreenState();
}

class _WatchPartyHistoryScreenState extends State<WatchPartyHistoryScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<WatchPartyHistoryController>().hasNext()) {
        Get.find<WatchPartyHistoryController>().getPartyHistory();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WatchPartyRepo(apiClient: Get.find()));
    Get.put(WatchPartyHistoryPusherController(apiClient: Get.find()));
    final controller = Get.put(WatchPartyHistoryController(
      repo: Get.find(),
      pushController: Get.find(),
    ));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
      scrollController.addListener(scrollListener);
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: MyStrings.watchParty,
        actions: [
          GestureDetector(
            onTap: () {
              Get.find<WatchPartyHistoryController>().clearInputFiled();

              CustomBottomSheet(bgColor: MyColor.bgColor, child: const JoinPartyBottomSheet()).customBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                color: MyColor.primaryColor,
              ),
              child: Text(
                MyStrings.joinParty.tr,
                style: mulishRegular.copyWith(),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GetBuilder<WatchPartyHistoryController>(
        builder: (controller) {
          return RefreshIndicator(
            backgroundColor: MyColor.cardBg,
            color: MyColor.primaryColor,
            onRefresh: () async {
              controller.loadData();
            },
            child: Padding(
              padding: Dimensions.padding,
              child: (controller.isLoading)
                  ? ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return LoadingItems();
                      },
                    )
                  : controller.isLoading == false && controller.partyList.isEmpty
                      ? const NoDataFoundScreen()
                      : ListView.builder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.partyList.length + 1,
                          itemBuilder: (context, index) {
                            if (controller.partyList.length == index) {
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
                                if (controller.partyList[index].status.toString() != "0") {
                                  Get.toNamed(
                                    RouteHelper.watchPartyRoomScreen,
                                    arguments: [controller.partyList[index].partyCode.toString(), "0"],
                                  );
                                }
                              },
                              child: PartyHistoryCard(
                                controller: controller,
                                party: controller.partyList[index],
                              ).animate().fade(
                                    delay: (100 * index).ms,
                                    duration: (index * 1000).ms,
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
