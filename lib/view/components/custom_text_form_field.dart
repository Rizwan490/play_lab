import 'package:flutter/material.dart';

import '../../constants/my_strings.dart';
import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
class InputTextFieldWidget extends StatefulWidget {

  final TextEditingController controller;
  final String hintText;
  final Color hintTextColor;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color fillColor;
  final bool isAddMargin;
  final Color textColor;
  final ValueChanged? onChanged;
  final bool isPassword;

  const InputTextFieldWidget({
    super.key,
    this.isPassword=false,
    this.isAddMargin=true,
    this.textColor=MyColor.colorWhite,
    this.hintTextColor=MyColor.bodyTextColor,
    this.fillColor=MyColor.textFieldColor,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged
  });

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          readOnly: widget.readOnly!,
          obscureText: widget.isPassword ? _obscureText : false,
          style: mulishSemiBold.copyWith(color: widget.textColor),
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: (String? value){
            if(value!.isEmpty){
              return MyStrings.pleaseFillOutTheField;
            }else{
              return null;
            }
          },
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide:const BorderSide(
                    color: Colors.transparent, width: 0
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: const BorderSide(color: Colors.transparent, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide:const BorderSide(color: MyColor.primaryColor, width: 0.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: const BorderSide(color: Colors.red, width: 0.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                borderSide: const BorderSide(color: Colors.red, width: 0.5),
              ),
              filled: true,
              fillColor: widget.fillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              hintText: widget.hintText,
              hintStyle: mulishLight.copyWith(color: widget.hintTextColor),
              suffixIcon: widget.isPassword ? Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
              // child: Image.asset(widget.prefixIconUrl),
              child: IconButton(icon:Icon(_obscureText ? Icons.visibility_off : Icons.visibility,color: MyColor.hintTextColor,size: 20,),
                onPressed: _toggle,
              ),
            ) : const SizedBox.shrink(),
          ),
        ),
        widget.isAddMargin?const SizedBox(height: 16,):const SizedBox()
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}