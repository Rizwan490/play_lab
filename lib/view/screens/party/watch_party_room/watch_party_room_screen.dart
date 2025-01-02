import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/pusher_controller/pusher_watch_room_helper_controller.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/data/repo/watch_party/watch_party_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/screens/party/watch_party_room/widget/party_room_body_widget.dart';
import 'package:play_lab/view/screens/party/watch_party_room/widget/party_room_name_data.dart';
import 'package:play_lab/view/screens/party/watch_party_room/widget/watch_party_video_player.dart';
import 'package:play_lab/view/screens/rent/widget/loading_items.dart';
import 'package:play_lab/view/will_pop_widget.dart';

class WatchPartyRoom extends StatefulWidget {
  const WatchPartyRoom({super.key});

  @override
  State<WatchPartyRoom> createState() => _WatchPartyRoomState();
}

class _WatchPartyRoomState extends State<WatchPartyRoom> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WatchPartyRepo(apiClient: Get.find()));
    final controller = Get.put(WatchPartyController(repo: Get.find()));
    final pusherController = Get.put(PusherWatchRoomHelperController(apiClient: Get.find(), controller: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pusherController.subscribePusher();
      controller.loadData(
        id: Get.arguments[0].toString(),
        guestId: Get.arguments[1] ?? ''.toString(),
        fromHistory: false,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<PusherWatchRoomHelperController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: 'closeParty', //custom
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.secondaryColor,
          body: GetBuilder<WatchPartyController>(builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<PusherWatchRoomHelperController>(builder: (pushController) {
                    return pushController.isPusherLoading
                        ? AspectRatio(
                            aspectRatio: 16 / 9,
                            child: LoadingItems(),
                          )
                        : const WatchPartyVideoPlayerWidget();
                  }),
                  const CustomSizedBox(),
                  const PartyRoomNameData(),
                  const CustomSizedBox(height: 20),
                  controller.isLoading
                      ? Column(
                          children: [
                            LoadingItems(height: context.width / 6),
                            LoadingItems(height: context.width),
                          ],
                        )
                      : const PartyRoomBodyWidget(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
