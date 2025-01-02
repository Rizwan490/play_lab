import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/subscribe_plan_controller/subscribe_plan_controller.dart';
import 'package:play_lab/data/repo/subscribe_plan_repo/subscribe_plan_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/header_text.dart';
import 'package:play_lab/view/screens/subscribe_plan/widget/subscrible_plan_shimmer.dart';
import '../../../constants/my_strings.dart';

class SubscribePlanScreen extends StatefulWidget {
  const SubscribePlanScreen({super.key});

  @override
  State<SubscribePlanScreen> createState() => _SubscribePlanScreenState();
}

class _SubscribePlanScreenState extends State<SubscribePlanScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<SubscribePlanController>().fetchNewPlanList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<SubscribePlanController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SubscribePlanRepo(apiClient: Get.find()));
    final controller = Get.put(SubscribePlanController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchInitialValue();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscribePlanController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.secondaryColor,
        appBar: const CustomAppBar(
          title: MyStrings.subscribePLan,
          bgColor: Colors.transparent,
          isShowBackBtn: true,
        ),
        body: controller.isLoading
            ? const SubscribePlanShimmer()
            : !(controller.isLoading) && controller.planList.isEmpty
                ? const NoDataFoundScreen()
                : ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.planList.length + 1,
                    itemBuilder: (context, index) {
                      if (controller.planList.length == index) {
                        return controller.hasNext()
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: MyColor.colorWhite,
                              ))
                            : const SizedBox();
                      }
                      return GestureDetector(
                        onTap: () {
                          if (controller.planList[index].inAppProduct != null && controller.availableInAppPurchase == true) {
                            controller.buyIAPProduct(controller.planList[index]);
                          } else {
                            controller.buyPlan(index);
                          }
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
                                      controller.planList[index].name?.tr ?? '',
                                      style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge, color: MyColor.colorWhite),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        HeaderText(
                                          text: '${controller.planList[index].duration ?? ''} ${MyStrings.days.tr}',
                                          textStyle: mulishBold.copyWith(color: MyColor.colorWhite.withOpacity(.75), fontSize: Dimensions.fontHeader),
                                        ),
                                        if (controller.availableInAppPurchase && controller.planList[index].inAppProduct?.price != null) ...[
                                          Text(
                                            '${controller.planList[index].inAppProduct?.price}',
                                            style: mulishSemiBold.copyWith(color: MyColor.primaryText, fontSize: Dimensions.fontLarge),
                                          ),
                                        ] else ...[
                                          Text(
                                            '${StringConverter.twoDecimalPlaceFixedWithoutRounding(controller.planList[index].pricing ?? '0')} ${controller.currency}',
                                            style: mulishSemiBold.copyWith(color: MyColor.primaryText, fontSize: Dimensions.fontLarge),
                                          )
                                        ],
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
                  ),
      ),
    );
  }
}
