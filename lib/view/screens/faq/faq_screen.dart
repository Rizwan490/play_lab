import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/data/controller/faq_controller/faq_controller.dart';
import 'package:play_lab/data/repo/faq_repo/faq_repo.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/no_data_widget.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';
import 'faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FaqRepo(apiClient: Get.find()));
    final controller = Get.put(FaqController(faqRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: CustomAppBar(isShowBackBtn: true, title: MyStrings.faq.tr),
          body: GetBuilder<FaqController>(
            builder: (controller) => controller.isLoading
                ? const CustomLoader()
                : controller.isLoading == false && controller.faqList.isEmpty
                    ? const NoDataFoundScreen()
                    : SingleChildScrollView(
                        padding: Dimensions.padding,
                        physics: const BouncingScrollPhysics(),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.faqList.length,
                          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                          itemBuilder: (context, index) => FaqListItem(
                              answer: (controller.faqList[index].dataValues?.answer ?? '').tr,
                              question: (controller.faqList[index].dataValues?.question ?? '').tr,
                              index: index,
                              press: () {
                                controller.changeSelectedIndex(index);
                              },
                              selectedIndex: controller.selectedIndex),
                        ),
                      ),
          )),
    );
  }
}
