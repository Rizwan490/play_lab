import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final Color? hintColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final VoidCallback? onTap;
  final Function? onChanged;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final IconData? prefixIcon;
  final bool isSearch;
  final bool isDropDown;
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final String? errorText;
  final double borderRadius;
  final FormFieldValidator? validator;
  final Widget? suffixIcon;
  const CustomTextField({
    super.key,
    this.hintText = '',
    this.controller,
    this.borderRadius = 4,
    this.focusNode,
    this.nextFocus,
    this.hintColor = MyColor.colorWhite,
    this.isDropDown = false,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor = MyColor.textFieldColor,
    this.onSubmit,
    required this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl,
    this.prefixIcon,
    this.errorText,
    this.isSearch = false,
    this.validator,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        // errorStyle: ,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: BorderSide(width: 1, color: MyColor.gbr),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: const BorderSide(width: 1, color: MyColor.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          borderSide: BorderSide(width: 1, color: MyColor.gbr),
        ),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)), borderSide: const BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)), borderSide: const BorderSide(width: 1, color: Colors.red)),
        isDense: true,
        hintText: widget.hintText.tr,
        fillColor: widget.fillColor,
        hintStyle: mulishRegular.copyWith(fontSize: Dimensions.fontDefault, color: widget.hintColor),
        filled: true,
        prefixIcon: widget.isShowPrefixIcon
            ? Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
                child: Icon(
                  widget.prefixIcon,
                  color: MyColor.colorWhite,
                ),
              )
            : const SizedBox.shrink(),
        prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor), onPressed: _toggle)
                : widget.isIcon
                    ? IconButton(
                        onPressed: widget.onSuffixTap,
                        icon: Icon(
                          widget.isSearch
                              ? Icons.search_outlined
                              : widget.isDropDown
                                  ? Icons.arrow_drop_down_sharp
                                  : Icons.expand_more,
                          size: 25,
                          color: widget.hintColor,
                        ),
                      )
                    : widget.suffixIcon
            : null,
      ),
      onTap: widget.onTap,
      onChanged: (text) => widget.onChanged!(text),
      onFieldSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!()
              : null,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
