import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:play_lab/core/utils/styles.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class OTPFieldWidget extends StatelessWidget {
  const OTPFieldWidget({super.key,required this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: mulishRegular.copyWith(color: MyColor.colorWhite),
        length: 6,
        textStyle: mulishRegular.copyWith(color: MyColor.colorWhite),
        obscureText: false,
        obscuringCharacter: '*',
        blinkWhenObscuring: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: 1,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 40,
          inactiveColor:  MyColor.textFiledFillColor,
          inactiveFillColor: MyColor.textFiledFillColor,
          activeFillColor: MyColor.primaryColor.withOpacity(.4),
          activeColor: MyColor.primaryColor.withOpacity(.4),
          selectedFillColor: MyColor.primaryColor.withOpacity(.4),
          selectedColor: MyColor.primaryColor.withOpacity(.4)
        ),
        cursorColor: MyColor.colorBlack,
        animationDuration:
        const Duration(milliseconds: 100),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (value) => onChanged!(value),
      ),
    );
  }
}
