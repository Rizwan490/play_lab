import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';

class PartyRoomChatWidget extends StatelessWidget {
  WatchPartyController controller;
  PartyRoomChatWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).orientation == Orientation.landscape ? context.height / 2 : context.height / 2 - 100,
      child: ListView.builder(
        itemCount: controller.chatList.length,
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(microseconds: 500),
            curve: Curves.easeIn,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyImageWidget(
                  imageUrl: '${UrlContainer.baseUrl}assets/images/user/profile/${controller.chatList[index].user?.image}',
                  height: 30,
                  width: 30,
                  isProfile: true,
                  radius: 50,
                ),
                const CustomSizedBox(width: 15, height: 0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "@${controller.chatList[index].user?.username ?? ''}",
                      style: mulishLight.copyWith(),
                    ),
                    Text(
                      "${controller.chatList[index].message?.replaceAll('\n', ' ')}",
                      style: mulishBold.copyWith(color: MyColor.colorWhite),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
