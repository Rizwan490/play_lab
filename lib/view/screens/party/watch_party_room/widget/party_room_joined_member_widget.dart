import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';

class PartyRoomJoinedMember extends StatelessWidget {
  WatchPartyController controller;

  PartyRoomJoinedMember({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).orientation == Orientation.landscape ? context.height / 2 : context.height / 2 - 100,
      child: controller.roomModel.data?.partyMembers != null && controller.roomModel.data!.partyMembers!.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: List.generate(
                  controller.partyMemberList.length,
                  (index) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                MyImageWidget(
                                  imageUrl: '${UrlContainer.baseUrl}assets/images/user/profile/${controller.partyMemberList[index].user?.image}',
                                  height: 30,
                                  width: 30,
                                  isProfile: true,
                                  radius: 50,
                                ),
                                const CustomSizedBox(width: 10, height: 0),
                                Text(
                                  "@${controller.roomModel.data?.partyMembers![index].user?.username}",
                                  style: mulishLight.copyWith(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (controller.isCurrentUserHost) ...[
                          IconButton(
                            onPressed: () {
                              AppDialog().removeUserPartyDialog(
                                context,
                                () {
                                  controller.removeUser(controller.roomModel.data?.partyMembers![index].id ?? '');
                                },
                                msgText: MyStrings.removeUserPartyMsg.tr,
                                username: "${controller.roomModel.data?.partyMembers![index].user?.username}",
                              );
                            },
                            icon: const Icon(Icons.delete, size: 18, color: MyColor.red),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
