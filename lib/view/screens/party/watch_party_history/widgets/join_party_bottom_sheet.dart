import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../data/controller/watch_party_controller/watch_party_history_controller.dart';
import '../../../../components/bottom-sheet/bottom_sheet_header_row.dart';
import '../../../../components/buttons/rounded_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/label_text.dart';
import '../../../../components/show_custom_snackbar.dart';

class JoinPartyBottomSheet extends StatelessWidget {
  const JoinPartyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchPartyHistoryController>(builder: (controller) {
      return controller.isJoinPartyBtnLoading
          ? SizedBox(
              height: context.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomLoader(),
                  const SizedBox(height: Dimensions.space20),
                  Text(
                    MyStrings.joinRequestPendingMsg.tr,
                    style: mulishRegular.copyWith(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BottomSheetHeaderRow(header: MyStrings.joinAParty),
                  const LabelText(text: MyStrings.partyCode, size: Dimensions.fontSmall),
                  CustomTextField(
                    controller: controller.partyCodeController,
                    onChanged: (v) {},
                    hintText: MyStrings.partyCodeEnterMsg,
                    hintColor: MyColor.colorGrey2,
                  ),
                  const SizedBox(height: 40),
                  RoundedButton(
                    text: MyStrings.join,
                    press: () {
                      if (controller.partyCodeController.text.isNotEmpty) {
                        controller.joinPartyRequest();
                      } else {
                        CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.plsEnterPartyCode], msg: [], isError: true);
                      }
                    },
                  ),
                ],
              ),
            );
    });
  }
}
