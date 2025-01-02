import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import '../../core/utils/my_color.dart';

class CustomSnackbar {
  static showCustomSnackbar({required List<String> errorList, required List<String> msg, required bool isError, int duration = 5}) {
    String message = '';
    if (isError) {
      if (errorList.isEmpty) {
        message = MyStrings.unKnownError.tr;
      } else {
        for (var element in errorList) {
          message = message.isEmpty ? '${message.tr}${element.tr}' : "${message.tr}\n${element.tr}";
        }
      }
      message = StringConverter.removeQuotationAndSpecialCharacterFromString(message);
    } else {
      if (msg.isEmpty) {
        message = MyStrings.success.tr;
      } else {
        for (var element in msg) {
          message = message.isEmpty ? '${message.tr}${element.tr}' : "${message.tr}\n${element.tr}";
        }
      }
      message = StringConverter.removeQuotationAndSpecialCharacterFromString(message);
    }
    message = message.isEmpty
        ? isError
            ? MyStrings.failedToUpdateProfile
            : MyStrings.profileUpdatedSuccessfully
        : message;
    if (Get.context == null) {
      Get.rawSnackbar(
        progressIndicatorBackgroundColor: MyColor.primaryColor,
        message: message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isError ? Colors.redAccent : MyColor.greenSuccessColor,
        borderRadius: 12,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        duration: Duration(seconds: duration),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else {
      Flushbar(
        message: message,
        margin: const EdgeInsets.all(Dimensions.space10),
        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
        backgroundColor: isError ? Colors.redAccent : MyColor.greenSuccessColor,
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: isError ? Colors.redAccent : MyColor.greenSuccessColor,
        forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        isDismissible: true,
      ).show(Get.context!);
    }
  }

  static showSnackbarWithoutTitle(BuildContext context, String message, {Color bg = MyColor.greenSuccessColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        content: Text(message),
      ),
    );
  }
}
