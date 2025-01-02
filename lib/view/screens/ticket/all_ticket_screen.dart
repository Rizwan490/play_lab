import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/date_converter.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/support/support_controller.dart';
import 'package:play_lab/data/repo/support/support_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/column_widget/card_column.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/floating_action_button/fab.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/shimmar/match_card_shimmer.dart';

class AllTicketScreen extends StatefulWidget {
  const AllTicketScreen({super.key});

  @override
  State<AllTicketScreen> createState() => _AllTicketScreenState();
}

class _AllTicketScreenState extends State<AllTicketScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<SupportController>().hasNext()) {
        Get.find<SupportController>().getSupportTicket();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiClient: Get.find()));
    final controller = Get.put(SupportController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(builder: (controller) {
      return Scaffold(
        backgroundColor: MyColor.bgColor,
        appBar: const CustomAppBar(title: MyStrings.supportTicket),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          color: MyColor.primaryColor,
          child: Column(
            children: [
              if (controller.ticketList.isEmpty && controller.isLoading == false) ...[const Expanded(child: NoDataFoundScreen())],
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: Dimensions.padding,
                  child: controller.isLoading
                      ? ListView.builder(
                          itemCount: 10,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return const MatchCardShimmer();
                          },
                        )
                      : ListView.separated(
                          controller: scrollController,
                          itemCount: controller.ticketList.length + 1,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                          itemBuilder: (context, index) {
                            if (controller.ticketList.length == index) {
                              return controller.hasNext() ? const CustomLoader(isPagination: true) : const SizedBox();
                            }
                            return GestureDetector(
                              onTap: () {
                                String id = controller.ticketList[index].ticket ?? '-1';
                                String subject = controller.ticketList[index].subject ?? '';
                                Get.toNamed(RouteHelper.ticketDetailsdScreen, arguments: [id, subject]);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space20 + 5),
                                decoration: BoxDecoration(color: MyColor.textFieldColor, borderRadius: BorderRadius.circular(Dimensions.mediumRadius), border: Border.all(color: MyColor.borderColor, width: 1)),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                            child: Column(
                                              children: [
                                                CardColumn(
                                                  header: "[${MyStrings.ticket.tr}#${controller.ticketList[index].ticket}] ${controller.ticketList[index].subject}",
                                                  body: "${controller.ticketList[index].subject}",
                                                  space: 5,
                                                  headerTextDecoration: mulishRegular.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  bodyTextDecoration: mulishRegular.copyWith(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                                          decoration: BoxDecoration(
                                            color: controller.getStatusColor(controller.ticketList[index].status ?? "0").withOpacity(0.2),
                                            border: Border.all(color: controller.getStatusColor(controller.ticketList[index].status ?? "0"), width: 1),
                                          ),
                                          child: Text(
                                            controller.getStatusText(controller.ticketList[index].status ?? '0'),
                                            style: mulishRegular.copyWith(
                                              color: controller.getStatusColor(controller.ticketList[index].status ?? "0"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                                          decoration: BoxDecoration(
                                            color: controller.getStatusColor(controller.ticketList[index].priority ?? "0", isPriority: true).withOpacity(0.2),
                                            border: Border.all(
                                              color: controller.getStatusColor(controller.ticketList[index].priority ?? "0", isPriority: true),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            controller.getStatus(controller.ticketList[index].priority ?? '1', isPriority: true),
                                            style: mulishRegular.copyWith(
                                              color: controller.getStatusColor(controller.ticketList[index].priority ?? "0", isPriority: true),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          DateConverter.getFormatedSubtractTime(controller.ticketList[index].createdAt ?? ''),
                                          style: mulishRegular.copyWith(fontSize: 10, color: MyColor.ticketDateColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FAB(
          callback: () {
            Get.toNamed(RouteHelper.newTicketScreen)?.then((value) => {Get.find<SupportController>().getSupportTicket()});
          },
        ),
      );
    });
  }
}
