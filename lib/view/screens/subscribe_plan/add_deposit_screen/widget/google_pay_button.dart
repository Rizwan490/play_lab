import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/data/controller/deposit_controller/add_new_deposit_controller.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';

import '../../../../../core/helper/config_helper.dart';

class MyGooglePayButton extends StatelessWidget {
  final String price;
  final String planName;

  const MyGooglePayButton({super.key, required this.price, required this.planName});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(builder: (controller) {
      return controller.isGooglePayLoading
          ? const RoundedLoadingButton()
          : GooglePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(ConfigHelper.defaultGooglePay),
              paymentItems: [
                PaymentItem(
                  label: planName,
                  amount: StringConverter.twoDecimalPlaceFixedWithoutRounding(price),
                  status: PaymentItemStatus.final_price,
                )
              ],
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (result) {
                controller.configureGoogleInAppPayment(result, price);
              },
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            );
    });
  }
}
