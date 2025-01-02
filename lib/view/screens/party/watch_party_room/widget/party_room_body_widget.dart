import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/custom_sized_box.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/divider/custom_divider.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/screens/party/watch_party_room/widget/party_room_chat_widget.dart';
import 'package:play_lab/view/screens/party/watch_party_room/widget/party_room_joined_member_widget.dart';

class PartyRoomBodyWidget extends StatefulWidget {
  const PartyRoomBodyWidget({super.key});

  @override
  State<PartyRoomBodyWidget> createState() => _PartyRoomBodyWidgetState();
}

class _PartyRoomBodyWidgetState extends State<PartyRoomBodyWidget> {
  bool isChatSelected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchPartyController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      MyImageWidget(
                        imageUrl: '${UrlContainer.baseUrl}assets/images/user/profile/${controller.roomModel.data?.partyRoom?.user?.image}',
                        height: 40,
                        width: 40,
                        radius: 50,
                        isProfile: true,
                      ),
                      const CustomSizedBox(width: 15, height: 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.roomModel.data?.partyRoom?.user?.firstName} ${controller.roomModel.data?.partyRoom?.user?.lastName}",
                            style: mulishMedium.copyWith(),
                          ),
                          Text(
                            controller.isCurrentUserHost ? MyStrings.youAreHostThisParty.tr : MyStrings.yourHostThisParty.tr,
                            style: mulishLight.copyWith(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (controller.isCurrentUserHost) ...[
                  GestureDetector(
                    onTap: () async {
                      if (controller.isClosePartyLoading == false) {
                        AppDialog().closePartyDialog(
                          context,
                          () async {
                            await controller.closeParty(controller.roomModel.data?.partyRoom?.id);
                          },
                          msgText: MyStrings.closePartyMsg.tr,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                        color: MyColor.closeRedColor,
                      ),
                      child: controller.isClosePartyLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: MyColor.colorWhite,
                              ),
                            )
                          : Text(MyStrings.closeParty.tr, style: mulishMedium.copyWith()),
                    ),
                  ),
                ] else ...[
                  GestureDetector(
                    onTap: () async {
                      if (controller.isClosePartyLoading == false) {
                        AppDialog().closePartyDialog(
                          context,
                          () async {
                            await controller.leaveParty();
                          },
                          msgText: MyStrings.leavePartyMsg.tr,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                        color: MyColor.closeRedColor,
                      ),
                      child: controller.isClosePartyLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: MyColor.colorWhite,
                              ),
                            )
                          : Text(MyStrings.leaveParty.tr, style: mulishMedium.copyWith()),
                    ),
                  ),
                ],
              ],
            ),
            const CustomSizedBox(height: 40),
            Expanded(
              flex: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColor.borderColor, width: .5),
                  borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: controller.isChatSelected
                          ? SizedBox(
                              child: GestureDetector(
                                onTap: () {
                                  controller.changeChatSelection();
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_back,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(MyStrings.chat, style: mulishMedium.copyWith()),
                                  ],
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(MyStrings.liveChat.tr, style: mulishMedium.copyWith()),
                                if (controller.isCurrentUserHost) ...[
                                  GestureDetector(
                                    onTap: () {
                                      controller.changeChatSelection();
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.person_outline,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(MyStrings.joined.tr, style: mulishMedium.copyWith()),
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            ),
                    ),
                    const CustomDivider(space: 10),
                    controller.isChatSelected ? PartyRoomJoinedMember(controller: controller) : PartyRoomChatWidget(controller: controller),
                    controller.isChatSelected ? const SizedBox.shrink() : const CustomDivider(space: 0),
                    controller.isChatSelected
                        ? const SizedBox.shrink()
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              controller: controller.msgController,
                              textInputAction: TextInputAction.send,
                              onFieldSubmitted: (value) {
                                if (controller.msgController.text.isNotEmpty && controller.isSendingMsg == false) {
                                  controller.sendMessage(controller.roomModel.data?.partyRoom?.id);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "${MyStrings.chat.tr}...",
                                hintStyle: mulishMedium.copyWith(color: MyColor.colorWhite),
                                suffixIconConstraints: const BoxConstraints(maxHeight: 40, minHeight: 30, maxWidth: 40, minWidth: 30),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (controller.msgController.text.isNotEmpty && controller.isSendingMsg == false) {
                                      controller.sendMessage(controller.roomModel.data?.partyRoom?.id);
                                    }
                                  },
                                  child: controller.isSendingMsg
                                      ? const CustomLoader(
                                          isPagination: true,
                                        )
                                      : const Icon(
                                          Icons.send,
                                          color: MyColor.colorWhite,
                                        ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.landscape ? 10 : 50,
            ),
          ],
        ),
      );
    });
  }
}
