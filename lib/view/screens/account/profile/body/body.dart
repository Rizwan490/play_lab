import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/view/screens/account/profile/body/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../data/controller/account/profile_controller.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/from_errors.dart';
import '../../../../components/label_text.dart';
import '../../../../components/buttons/rounded_button.dart';

class Body extends StatelessWidget {
  const Body({super.key, this.comeFrom = 'profile'});
  final String comeFrom;

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().callFrom = comeFrom;
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
                            isEdit: comeFrom == 'profile' ? true : false,
                            imagePath: controller.imageUrl,
                            onClicked: () async {},
                          ),
                          Center(
                            child: comeFrom == "profile"
                                ? LabelText(
                                    text: '${MyStrings.username.tr} : ${controller.model.data?.user?.username ?? controller.profileRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userNameKey)}',
                                  )
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 15),
                          if (comeFrom == "profile") ...[
                            LabelText(text: MyStrings.firstName.tr, space: 12),
                            CustomTextField(
                              hintText: MyStrings.firstName.tr,
                              isShowBorder: true,
                              isPassword: false,
                              isShowSuffixIcon: false,
                              fillColor: MyColor.textFieldColor,
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.firstNameFocusNode,
                              controller: controller.firstNameController,
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
                            LabelText(space: 12, text: MyStrings.lastName.tr),
                            CustomTextField(
                              hintText: MyStrings.lastName.tr,
                              isShowBorder: true,
                              isPassword: false,
                              isShowSuffixIcon: false,
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              focusNode: controller.lastNameFocusNode,
                              controller: controller.lastNameController,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  controller.removeError(error: MyStrings.kLastNameNullError);
                                }
                                if (value.isEmpty) {
                                  controller.addError(error: MyStrings.kLastNameNullError);
                                }
                                return;
                              },
                              nextFocus: controller.addressFocusNode,
                            ),
                            const SizedBox(height: 15),
                          ] else ...[
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
                          ],
                          Visibility(
                            visible: comeFrom == 'profile' ? true : false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                LabelText(space: 12, text: MyStrings.emailAddress.tr),
                                CustomTextField(
                                  hintText: MyStrings.emailAddress.tr,
                                  isShowBorder: true,
                                  isPassword: false,
                                  isShowSuffixIcon: false,
                                  isEnabled: false,
                                  controller: controller.emailController,
                                  onChanged: (value) {
                                    return;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                LabelText(space: 12, text: MyStrings.mobileNumber.tr),
                                CustomTextField(
                                  hintText: MyStrings.mobileNumber,
                                  isShowBorder: true,
                                  isPassword: false,
                                  isEnabled: false,
                                  isShowSuffixIcon: false,
                                  controller: controller.mobileNoController,
                                  onSuffixTap: () {},
                                  onChanged: (value) {
                                    return;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const LabelText(space: 12, text: MyStrings.country),
                                CustomTextField(
                                  hintText: MyStrings.country,
                                  isShowBorder: true,
                                  isPassword: false,
                                  isEnabled: false,
                                  isShowSuffixIcon: false,
                                  controller: controller.countryController,
                                  onSuffixTap: () {},
                                  onChanged: (value) {
                                    return;
                                  },
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
                          FormError(errors: controller.errors),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: RoundedButton(
                              text: MyStrings.updateProfile,
                              press: () {
                                controller.updateProfile(comeFrom);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
            ));
  }
}
