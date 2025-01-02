import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/screens/account/payment_log_screen/widget/payment_log_list_item/payment_log_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/controller/payment_log/deposit_controller.dart';
import '../../../../data/enum/navigation_item.dart';
import '../../../../data/repo/deposit_repo/deposit_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/nav_drawer/custom_nav_drawer.dart';

class PaymentLogsScreen extends StatefulWidget {
  const PaymentLogsScreen({super.key});

  @override
  State<PaymentLogsScreen> createState() => _PaymentLogsScreenState();
}

class _PaymentLogsScreenState extends State<PaymentLogsScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.find<DepositController>().clearData();
    super.dispose();
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    Get.put(DepositController(depositRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationDrawerWidget.navigationItem = NavigationItem.payment;
      Get.find<DepositController>().beforeInitLoadData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.colorBlack,
        appBar: const CustomAppBar(title: MyStrings.paymentHistory),
        body: controller.isLoading
            ? const SizedBox(
                child: Center(child: CircularProgressIndicator(color: MyColor.primaryColor)),
              )
            : controller.depositList.isEmpty
                ? const NoDataFoundScreen(message: MyStrings.noTrxFound)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: GetBuilder<DepositController>(
                      builder: (controller) => ListView.builder(
                        itemCount: controller.depositList.length + 1,
                        shrinkWrap: true,
                        controller: _controller,
                        itemBuilder: (builder, index) {
                          if (index == controller.depositList.length) {
                            return Center(
                              child: controller.hasNext()
                                  ? const CircularProgressIndicator(
                                      color: MyColor.primaryColor,
                                    )
                                  : const SizedBox(),
                            );
                          }
                          return DepositHistoryListItem(
                            listItem: controller.depositList[index],
                            index: index,
                            currency: controller.currency,
                          );
                        },
                      ),
                    ),
                  ),
      ),
    );
  }
}
