import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/buttons/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/my_color.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

showExitDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    dialogBackgroundColor: MyColor.otpBgColor,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    onDismissCallback: (type) {
      if (DismissType.btnCancel == type) {
        Get.back();
      }
    },
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          MyStrings.appExitMsg.tr,
          textAlign: TextAlign.center,
          style: mulishRegular.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: RoundedButton(
                    text: MyStrings.no,
                    vPadding: 15,
                    color: MyColor.colorGrey,
                    press: () {
                      Navigator.pop(context);
                    })),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RoundedButton(
                text: MyStrings.yes,
                vPadding: 15,
                press: () {
                  SystemNavigator.pop();
                  FlutterExitApp.exitApp();
                },
                color: MyColor.closeRedColor,
              ),
            )
          ],
        )
      ],
    ),
    showCloseIcon: true,
  ).show();
}
