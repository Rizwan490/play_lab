import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_controller.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:play_lab/view/screens/rent/widget/loading_items.dart';

class PartyRoomNameData extends StatelessWidget {
  const PartyRoomNameData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchPartyController>(builder: (controller) {
      return controller.isLoading
          ? LoadingItems(height: context.width / 8)
          : Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.roomModel.data?.item?.title?.tr ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(border: Border.all(color: MyColor.colorWhite, width: .5), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              controller.roomModel.data?.partyRoom?.partyCode ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: controller.roomModel.data?.partyRoom?.partyCode ?? '')).then((value) {
                                CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.successfullyCopiedToClipboard], isError: false);
                              });
                            },
                            child: const Icon(
                              Icons.copy,
                              color: MyColor.colorWhite,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
    });
  }
}
