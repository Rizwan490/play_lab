import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';

class AppDialog {
  void joinRequestDialog(
    BuildContext context,
    String username, {
    required VoidCallback accept,
    required VoidCallback reject,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MyColor.cardBg,
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space30 + 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 50 + Dimensions.space10,
                  bottom: Dimensions.space15,
                  left: Dimensions.space10,
                  right: Dimensions.space10,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Text(username.toUpperCase(), style: mulishBold.copyWith(fontSize: 18, color: MyColor.colorWhite)),
                    const SizedBox(height: Dimensions.space10),
                    Text(MyStrings.joinPartyMsg.tr, style: mulishRegular.copyWith(fontSize: 18, color: MyColor.colorWhite)),
                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            reject();
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.redCancelTextColor, borderRadius: BorderRadius.circular(Dimensions.cornerRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.reject.tr.toUpperCase(),
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        GestureDetector(
                          onTap: () {
                            accept();
                            Get.back();
                          },
                          child: Container(
                            width: context.width / 3,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space30,
                              vertical: Dimensions.space10,
                            ),
                            decoration: BoxDecoration(color: MyColor.greenSuccessColor, borderRadius: BorderRadius.circular(Dimensions.cornerRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.accept.toUpperCase(),
                                // MyStrings.join.tr.toUpperCase(),
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space20),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: MediaQuery.of(context).padding.left,
                right: MediaQuery.of(context).padding.right,
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColor.greenSuccessColor,
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 40,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void warningAlertDialog(BuildContext context, VoidCallback press, {String? msgText}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MyColor.cardBg,
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space50 - 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: Dimensions.space50 - 10, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space20),
                    Text(msgText ?? '', style: mulishRegular.copyWith()),
                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            press();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.greenSuccessColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.yes.tr,
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.redCancelTextColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.no.tr,
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space20),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: MediaQuery.of(context).padding.left,
                right: MediaQuery.of(context).padding.right,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColor.closeRedColor,
                    ),
                    child: const Icon(
                      Icons.person_remove,
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void removeUserPartyDialog(
    BuildContext context,
    VoidCallback press, {
    String? msgText,
    required String username,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MyColor.cardBg,
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space50 - 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: Dimensions.space50 - 10, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space20),
                    Center(child: Text(username.toUpperCase(), style: mulishBold.copyWith(fontSize: 18), textAlign: TextAlign.center)),
                    const SizedBox(height: Dimensions.space5),
                    Text(
                      msgText ?? '',
                      style: mulishRegular.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.redCancelTextColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.no.tr,
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            press();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.greenSuccessColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.yes.tr,
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space20),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: MediaQuery.of(context).padding.left,
                right: MediaQuery.of(context).padding.right,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColor.closeRedColor,
                    ),
                    child: const Icon(
                      Icons.person_remove,
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void closePartyDialog(
    BuildContext context,
    VoidCallback press, {
    String? msgText,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MyColor.cardBg,
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space50 - 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: Dimensions.space50 - 10, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space20),
                    Text(
                      (msgText ?? '').tr,
                      style: mulishRegular.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.space20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.redCancelTextColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.no.tr,
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space10),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            press();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                            decoration: BoxDecoration(color: MyColor.greenSuccessColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                            child: Center(
                              child: Text(
                                MyStrings.yes.tr,
                                style: mulishRegular.copyWith(color: MyColor.colorWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space20),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: MediaQuery.of(context).padding.left,
                right: MediaQuery.of(context).padding.right,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColor.redCancelTextColor,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void rentItemDialog(
    BuildContext context,
    VoidCallback press, {
    required String msgText,
    required String imageUrl,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        surfaceTintColor: MyColor.transparentColor,
        insetAnimationCurve: Curves.easeIn,
        backgroundColor: MyColor.otpBgColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space50 - 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: Dimensions.space20, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.confirmationAlert,
                  style: mulishMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: Dimensions.space20),
                Text(
                  ('${MyStrings.rentSubscriptionMsg}$msgText').tr,
                  style: mulishRegular.copyWith(),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: Dimensions.space20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space8),
                        decoration: BoxDecoration(color: MyColor.redCancelTextColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                        child: Center(
                          child: Text(
                            MyStrings.no.tr,
                            style: mulishRegular.copyWith(color: MyColor.colorWhite),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        press();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space8),
                        decoration: BoxDecoration(color: MyColor.greenSuccessColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                        child: Center(
                          child: Text(
                            MyStrings.yes.tr,
                            style: mulishRegular.copyWith(color: MyColor.colorWhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void subcribcritionAlert(
    BuildContext context,
    VoidCallback press, {
    required String msgText,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        surfaceTintColor: MyColor.transparentColor,
        insetAnimationCurve: Curves.easeIn,
        backgroundColor: MyColor.otpBgColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space50 - 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: Dimensions.space20, bottom: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: MyColor.cardBg, borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(MyStrings.confirmationAlert, style: mulishMedium.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: Dimensions.space20),
                Text(
                  (msgText).tr,
                  style: mulishRegular.copyWith(),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: Dimensions.space30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space8),
                        decoration: BoxDecoration(color: MyColor.redCancelTextColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                        child: Center(
                          child: Text(
                            MyStrings.no.tr,
                            style: mulishRegular.copyWith(color: MyColor.colorWhite),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        press();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space8),
                        decoration: BoxDecoration(color: MyColor.greenSuccessColor, borderRadius: BorderRadius.circular(Dimensions.cardRadius)),
                        child: Center(
                          child: Text(
                            MyStrings.yes.tr,
                            style: mulishRegular.copyWith(color: MyColor.colorWhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.space20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
