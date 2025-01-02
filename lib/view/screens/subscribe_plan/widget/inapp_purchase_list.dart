import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/subscribe_plan_controller/subscribe_plan_controller.dart';
import 'package:play_lab/view/components/header_text.dart';

class InAppPurchaseData extends StatelessWidget {
  const InAppPurchaseData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscribePlanController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: controller.inapProducts.length + 1,
        itemBuilder: (context, index) {
          if (controller.inapProducts.length == index) {
            return controller.hasNext()
                ? const Center(
                    child: CircularProgressIndicator(
                    color: MyColor.colorWhite,
                  ))
                : const SizedBox();
          }

          return GestureDetector(
            onTap: () {
              // controller.buyPlan(index);
              // controller.buy(controller.);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              margin: index == 0 ? const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 35) : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [MyColor.primaryColor500, MyColor.primaryColor],
                ),
                color: MyColor.primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
              ),
              child: controller.isBuyPlanClick && controller.sIndex == index
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (controller.inapProducts[index].id.split('_')[0]).toString().capitalizeFirst ?? '',
                          style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge, color: MyColor.colorWhite),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeaderText(
                              text: '${controller.inapProducts[index].description.split('days')[0].replaceAll('Get', '').trim()} ${MyStrings.days.tr}',
                              textStyle: mulishBold.copyWith(color: MyColor.colorWhite.withOpacity(.75), fontSize: Dimensions.fontHeader),
                            ),
                            Text(
                              "${StringConverter.twoDecimalPlaceFixedWithoutRounding(controller.inapProducts[index].rawPrice.toString())} ${controller.inapProducts[index].currencyCode}",
                              style: mulishSemiBold.copyWith(color: MyColor.primaryText, fontSize: Dimensions.fontLarge),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
            ),
          );
        },
      );
    });
  }
}
