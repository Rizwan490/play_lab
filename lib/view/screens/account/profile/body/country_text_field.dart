import 'package:flutter/material.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/label_text.dart';
import 'package:get/get.dart';

class CountryTextField extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const CountryTextField({super.key, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelText(text: MyStrings.selectACountry),
        const SizedBox(height: Dimensions.textToTextSpace),
        InkWell(
          onTap: press,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
            decoration: BoxDecoration(
              color: MyColor.textFieldColor,
              borderRadius: BorderRadius.circular(Dimensions.cardRadius),
              border: Border.all(
                color: MyColor.gbr,
                width: .5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text.tr, style: mulishRegular.copyWith(color: MyColor.textColor)),
                const Icon(
                  Icons.expand_more_rounded,
                  color: MyColor.hintTextColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
