import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/my_strings.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../data/controller/deposit_controller/add_new_deposit_controller.dart';
import '../../../../components/divider/custom_divider.dart';
import 'custom_row.dart';

class AddMoneyInfoWidget extends StatelessWidget {
  const AddMoneyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(Dimensions.space15),
        decoration: BoxDecoration(
          color: MyColor.transparentColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRow(showImage: true, firstText: MyStrings.amount, lastText: "${controller.mainAmount.toString()} ${controller.currency}"),
            const CustomDivider(space: Dimensions.space15),
            CustomRow(showImage: true, firstText: MyStrings.charge, lastText: controller.charge),
            const CustomDivider(space: Dimensions.space15),
            CustomRow(showImage: true, firstText: MyStrings.payable, lastText: controller.payableText),
          ],
        ),
      ),
    );
  }
}
