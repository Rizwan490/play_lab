import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/dialog/app_dialog.dart';
import 'package:play_lab/view/components/dialog/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({super.key, required this.child, this.nextRoute = ''});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          if (nextRoute == 'closeParty') {
            AppDialog().closePartyDialog(
              context,
              msgText: MyStrings.closePartyMsg.tr,
              () {
                Get.offAndToNamed(nextRoute);
              },
            );
          } else if (nextRoute.isEmpty) {
            showExitDialog(context);
          } else {
            Get.offAndToNamed(nextRoute);
          }
        },
        child: child);
  }
}
