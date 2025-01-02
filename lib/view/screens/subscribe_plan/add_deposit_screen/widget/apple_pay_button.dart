import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:play_lab/data/controller/deposit_controller/add_new_deposit_controller.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';

import '../../../../../core/helper/config_helper.dart';
import '../../../../../core/helper/string_format_helper.dart';

class MyApplePayButton extends StatelessWidget {
  final String price;
  final String planName;

  const MyApplePayButton({super.key, required this.price, required this.planName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(builder: (controller) {
      return controller.isApplePayLoading
          ? const RoundedLoadingButton()
          : ApplePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(ConfigHelper.defaultApplePay),
              paymentItems: [
                PaymentItem(
                  label: planName.toString(),
                  amount: StringConverter.twoDecimalPlaceFixedWithoutRounding(price),
                  status: PaymentItemStatus.final_price,
                )
              ],
              style: ApplePayButtonStyle.black,
              width: double.infinity,
              height: 50,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (result) {
                controller.configureAppleInAppPayment(result, price);
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            );
    });
  }
}
