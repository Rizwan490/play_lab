import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:play_lab/view/screens/subscribe_plan/add_deposit_screen/widget/add_money_info_widget.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/deposit_controller/add_new_deposit_controller.dart';
import '../../../../data/model/deposit/main_deposit_method_response_model.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/text_field_container2.dart';

class Body extends StatefulWidget {
  final String price;
  final String planName;
  const Body({super.key, required this.price, required this.planName});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: MyColor.primaryColor,
                    ),
                  )
                : Center(
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.fontExtraLarge),
                      margin: Dimensions.dialogContainerMargin,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColor.colorBlack,
                          border: Border.all(color: Colors.white54, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                  text:
                                      "${Get.previousRoute == RouteHelper.movieDetailsScreen ? MyStrings.youAreRequestedForRent.tr : MyStrings.youAreRequestedForPlan.tr}\n",
                                  style: mulishRegular.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontExtraLarge),
                                  children: [
                                    TextSpan(
                                      text: '${widget.planName.tr}\n',
                                      style: mulishSemiBold.copyWith(
                                          color: MyColor.primaryColor,
                                          fontSize: Dimensions.fontOverLarge),
                                    ),
                                    TextSpan(
                                      text: "${MyStrings.nowYouHaveToPay.tr} ",
                                      style: mulishRegular.copyWith(
                                          color: Colors.white,
                                          fontSize: Dimensions.fontExtraLarge),
                                    ),
                                    TextSpan(
                                      text: StringConverter
                                          .twoDecimalPlaceFixedWithoutRounding(
                                              widget.price),
                                      style: mulishSemiBold.copyWith(
                                          color: MyColor.primaryColor,
                                          fontSize: Dimensions.fontOverLarge),
                                    ),
                                    TextSpan(
                                      text: ' ${controller.currency}',
                                      style: mulishRegular.copyWith(
                                          color: Colors.white,
                                          fontSize: Dimensions.fontExtraLarge),
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            MyStrings.paymentMethod.tr,
                            style: mulishSemiBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFieldContainer2(
                              fillColor: MyColor.textFiledFillColor,
                              onTap: () {},
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColor.colorWhite,
                                      strokeAlign: 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButton<Methods>(
                                  hint: Text(MyStrings.selectAMethod.tr),
                                  dropdownColor: MyColor.textFieldColor,
                                  value: controller.paymentMethod,
                                  elevation: 8,
                                  icon:
                                      const Icon(Icons.arrow_drop_down_circle),
                                  iconDisabledColor: Colors.red,
                                  iconEnabledColor: MyColor.primaryColor,
                                  isExpanded: true,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (Methods? newValue) {
                                    controller.setPaymentMethod(
                                        newValue, widget.price);
                                  },
                                  items: controller.paymentMethodList
                                      .map((Methods method) {
                                    return DropdownMenuItem<Methods>(
                                      value: method,
                                      child: Text(
                                        method.name.toString().tr,
                                        style: mulishRegular.copyWith(
                                            color: MyColor.colorWhite),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          const AddMoneyInfoWidget(),
                          const SizedBox(
                            height: 30,
                          ),
                          controller.isLoading
                              ? const RoundedLoadingButton()
                              : Center(
                                  child: RoundedButton(
                                    width: 1,
                                    press: () {
                                      controller.submitDeposit(widget.price);
                                    },
                                    text: MyStrings.payNow.tr,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
