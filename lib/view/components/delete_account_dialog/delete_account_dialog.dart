import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/styles.dart';
import '../../../data/controller/nav_controller/nav_drawer_controller.dart';
import '../buttons/rounded_button.dart';
import '../buttons/rounded_loading_button.dart';

showDeleteDialog(BuildContext context) {
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
    onDismissCallback: (type) {},
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    body: const DialogBody(),
    showCloseIcon: true,
  ).show();
}

class DialogBody extends StatefulWidget {
  const DialogBody({super.key});

  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  bool isSubmitLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          MyStrings.deleteMsg.tr,
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
                child: isSubmitLoading
                    ? const RoundedLoadingButton(vPadding: 15)
                    : RoundedButton(
                        text: MyStrings.yes,
                        vPadding: 15,
                        press: () async {
                          setState(() {
                            isSubmitLoading = true;
                          });

                          await Get.find<NavDrawerController>().deleteUser();

                          setState(() {
                            isSubmitLoading = false;
                          });
                        },
                        color: MyColor.closeRedColor,
                      ))
          ],
        )
      ],
    );
  }
}
