import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:play_lab/view/components/buttons/rounded_button.dart';

import '../../../../../constants/my_strings.dart';

class ButtonGetStart extends StatelessWidget {
  final Callback press;
  const ButtonGetStart({super.key, required this.press});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RoundedButton(
        text: MyStrings.getStarted.tr,
        press: press,
        vRadius: 8,
        vPadding: 20,
      ),
    );
  }
}
