import 'package:flutter/material.dart';
import 'package:play_lab/view/components/custom_text_form_field.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
import 'package:get/get.dart';

class CountryFieldWidget extends StatefulWidget {

  final TextEditingController controller;
  final String  hintText;
  final TextInputType? keyboardType;
  final String? currency;
  final ValueChanged? onChanged;

  const CountryFieldWidget({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.currency
  });


  @override
  State<CountryFieldWidget> createState() => _CountryFieldWidgetState();
}

class _CountryFieldWidgetState extends State<CountryFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: MyColor.textFieldColor,
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radius)),
          border: Border.all(
              color: Colors.transparent
          )
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: Dimensions.fieldHeight * 1.3,
              decoration: const BoxDecoration(
                  color: MyColor.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.cornerRadius),topLeft: Radius.circular(Dimensions.cornerRadius)),
              ),
              child: Center(
                child: Text(
                  widget.currency?.tr??'',
                  overflow: TextOverflow.ellipsis,
                  style: mulishSemiBold.copyWith(color: MyColor.colorWhite),
                ),
              ),
            ),
             Expanded(
                child: InputTextFieldWidget(
                    isAddMargin:false,
                    controller:widget.controller,
                    hintText: widget.hintText,
                    onChanged:widget.onChanged),
              ),
          ],
        ),
      ),
    );
  }
}