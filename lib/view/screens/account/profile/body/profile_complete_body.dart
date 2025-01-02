import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import 'package:play_lab/view/screens/account/profile/body/country_bottom_sheet.dart.dart';
import 'package:play_lab/view/screens/account/profile/body/country_text_field.dart';
import 'package:play_lab/view/screens/account/profile/body/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../data/controller/account/profile_controller.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/label_text.dart';
import '../../../../components/buttons/rounded_button.dart';

class ProfileCompleteBody extends StatelessWidget {
  const ProfileCompleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().callFrom = "profile_complete";
    return GetBuilder<ProfileController>(
        builder: (controller) => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.bodyTextColor, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: MyColor.secondaryColor,
              ),
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: MyColor.primaryColor,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ProfileWidget(
                            isEdit: false,
                            imagePath: controller.imageUrl,
                            onClicked: () async {},
                          ),
                          const SizedBox(height: 15),
                          LabelText(text: MyStrings.username.tr, space: 12),
                          CustomTextField(
                            hintText: MyStrings.username.tr,
                            isShowBorder: true,
                            isPassword: false,
                            isShowSuffixIcon: false,
                            fillColor: MyColor.textFieldColor,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: controller.userNameFocusNode,
                            controller: controller.userNameController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                controller.removeError(error: MyStrings.kFirstNameNullError);
                              }
                              if (value.isEmpty) {
                                controller.addError(error: MyStrings.kFirstNameNullError);
                              }
                              return;
                            },
                            nextFocus: controller.lastNameFocusNode,
                          ),
                          const SizedBox(height: 15),
                          CountryTextField(
                            press: () {
                              CountryBottomSheet.showProfileCompleteBottomSheet(context, controller);
                            },
                            text: controller.countryName == null ? MyStrings.selectACountry.tr : (controller.countryName)!.tr,
                          ),
                          Visibility(
                            visible: controller.countryName != null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                LabelText(space: 12, text: MyStrings.mobileNumber.tr),
                                Row(
                                  children: [
                                    Container(
                                      height: 57,
                                      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: MyColor.textFieldColor,
                                        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                        border: Border.all(
                                          color: MyColor.primaryColor,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          MyImageWidget(
                                            imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", controller.countryCode.toString().toLowerCase()),
                                            height: Dimensions.space30 - 5,
                                            width: Dimensions.space50 - 10,
                                          ),
                                          const SizedBox(width: Dimensions.space5),
                                          Text(
                                            "+${controller.mobileCode}",
                                            style: mulishRegular.copyWith(color: MyColor.primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.space5 + 3),
                                    Expanded(
                                      child: CustomTextField(
                                        hintText: MyStrings.mobileNumber,
                                        isShowBorder: true,
                                        isPassword: false,
                                        isShowSuffixIcon: false,
                                        controller: controller.mobileNoController,
                                        onSuffixTap: () {},
                                        onChanged: (value) {
                                          return;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          const LabelText(space: 12, text: MyStrings.address),
                          CustomTextField(
                            hintText: MyStrings.address,
                            isShowBorder: true,
                            isPassword: false,
                            isShowSuffixIcon: false,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: controller.addressFocusNode,
                            controller: controller.addressController,
                            onSuffixTap: () {},
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                controller.removeError(error: MyStrings.kPassNullError);
                              }
                              if (value.isEmpty) {
                                controller.addError(error: MyStrings.kPassNullError);
                              }
                              return;
                            },
                            nextFocus: controller.stateFocusNode,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const LabelText(space: 12, text: MyStrings.state),
                          CustomTextField(
                            hintText: MyStrings.state,
                            isShowBorder: true,
                            isPassword: false,
                            isShowSuffixIcon: false,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: controller.stateFocusNode,
                            controller: controller.stateController,
                            onSuffixTap: () {},
                            onChanged: (value) {
                              return;
                            },
                            nextFocus: controller.zipCodeFocusNode,
                          ),
                          const SizedBox(height: 15),
                          const LabelText(space: 12, text: MyStrings.zipCode),
                          CustomTextField(
                            hintText: MyStrings.zipCode,
                            isShowBorder: true,
                            isPassword: false,
                            isShowSuffixIcon: false,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            focusNode: controller.zipCodeFocusNode,
                            controller: controller.zipCodeController,
                            onSuffixTap: () {},
                            onChanged: (value) {
                              return;
                            },
                            nextFocus: controller.cityFocusNode,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const LabelText(space: 12, text: MyStrings.city),
                          CustomTextField(
                            hintText: MyStrings.city,
                            isShowBorder: true,
                            isPassword: false,
                            isShowSuffixIcon: false,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            focusNode: controller.cityFocusNode,
                            controller: controller.cityController,
                            onSuffixTap: () {},
                            onChanged: (value) {
                              return;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          // FormError(errors: controller.errors),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: controller.submitLoading
                                ? const RoundedLoadingButton()
                                : RoundedButton(
                                    text: MyStrings.submit,
                                    press: () {
                                      controller.completeProfile();
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
            ));
  }
}
