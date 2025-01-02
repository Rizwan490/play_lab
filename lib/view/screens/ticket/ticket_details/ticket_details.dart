import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_icons.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/support/ticket_details_controller.dart';
import 'package:play_lab/data/repo/support/support_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/components/buttons/rounded_button.dart';
import 'package:play_lab/view/components/buttons/rounded_loading_button.dart';
import 'package:play_lab/view/components/circle_icon_button.dart';
import 'package:play_lab/view/components/custom_circle_animated_button.dart';
import 'package:play_lab/view/components/custom_loader/custom_loader.dart';
import 'package:play_lab/view/components/custom_text_field.dart';
import 'package:play_lab/view/components/label_text.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:play_lab/view/screens/ticket/ticket_details/widget/ticket_meassge_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  String title = "";
  @override
  void initState() {
    String ticketId = Get.arguments[0];
    title = Get.arguments[1];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiClient: Get.find()));
    var controller = Get.put(TicketDetailsController(repo: Get.find(), ticketId: ticketId));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: MyStrings.replyTicket,
      ),
      body: GetBuilder<TicketDetailsController>(builder: (controller) {
        return controller.isLoading
            ? const CustomLoader(
                isFullScreen: true,
              )
            : SingleChildScrollView(
                padding: Dimensions.padding,
                child: Container(
                  // padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: Dimensions.space15),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: MyColor.cardBg,
                            border: Border.all(
                              color: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(0.1),
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                                    decoration: BoxDecoration(
                                      color: controller.getStatusColor(controller.model.data?.myTickets?.status ?? "0").withOpacity(0.2),
                                      border: Border.all(color: controller.getStatusColor(controller.model.data?.myTickets?.status ?? "0"), width: 1),
                                      borderRadius: BorderRadius.circular(Dimensions.radius),
                                    ),
                                    child: Text(
                                      controller.getStatusText(controller.model.data?.myTickets?.status ?? '0'),
                                      style: mulishRegular.copyWith(
                                        color: controller.getStatusColor(controller.model.data?.myTickets?.status ?? "0"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10, height: 2),
                                  Expanded(
                                    child: Text(
                                      "[${MyStrings.ticket.tr}#${controller.model.data?.myTickets?.ticket ?? ''}] ${controller.model.data?.myTickets?.subject ?? ''}",
                                      style: mulishBold.copyWith(
                                        color: Theme.of(context).textTheme.titleLarge!.color!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                    height: 2,
                                  ),
                                ],
                              ),
                            ),
                            if (controller.model.data?.myTickets?.status != '3')
                              CustomCircleAnimatedButton(
                                onTap: () {
                                  controller.closeTicket(controller.model.data?.myTickets?.id.toString() ?? '-1');
                                },
                                height: 40,
                                width: 40,
                                backgroundColor: MyColor.red,
                                border: Border.all(color: MyColor.colorWhite, width: 1),
                                child: const Icon(Icons.close_rounded, color: MyColor.colorWhite, size: 20),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.space15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: MyColor.cardBg,
                            border: Border.all(
                              color: MyColor.borderColor.withOpacity(0.8),
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignOutside,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            LabelText(text: MyStrings.message.tr),
                            CustomTextField(
                              controller: controller.replyController,
                              hintText: MyStrings.yourReply.tr,
                              maxLines: 4,
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 10),
                            LabelText(text: MyStrings.attachments.tr),
                            controller.attachmentList.isNotEmpty ? const SizedBox(height: 20) : const SizedBox.shrink(),
                            controller.attachmentList.isNotEmpty
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ZoomTapAnimation(
                                          onTap: () {
                                            if (controller.attachmentList.length < 5) {
                                              controller.pickFile();
                                            } else {
                                              CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.attactmentError], msg: [], isError: true);
                                            }
                                          },
                                          child: Container(
                                            width: context.width / 5,
                                            height: context.width / 5,
                                            margin: const EdgeInsets.only(right: Dimensions.space10),
                                            decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: BorderRadius.circular(Dimensions.mediumRadius), border: Border.all(color: MyColor.borderColor, width: 1)),
                                            child: const Icon(Icons.add),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            controller.attachmentList.length,
                                            (index) => Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.all(Dimensions.space5),
                                                      decoration: const BoxDecoration(),
                                                      child: controller.isImage(controller.attachmentList[index].path)
                                                          ? ClipRRect(
                                                              borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                              child: Image.file(
                                                                controller.attachmentList[index],
                                                                width: context.width / 5,
                                                                height: context.width / 5,
                                                                fit: BoxFit.cover,
                                                              ))
                                                          : controller.isXlsx(controller.attachmentList[index].path)
                                                              ? Container(
                                                                  width: context.width / 5,
                                                                  height: context.width / 5,
                                                                  decoration: BoxDecoration(
                                                                    color: MyColor.colorWhite,
                                                                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                                    border: Border.all(color: MyColor.borderColor, width: 1),
                                                                  ),
                                                                  child: Center(
                                                                    child: SvgPicture.asset(
                                                                      MyIcons.xlsx,
                                                                      height: 45,
                                                                      width: 45,
                                                                    ),
                                                                  ),
                                                                )
                                                              : controller.isDoc(controller.attachmentList[index].path)
                                                                  ? Container(
                                                                      width: context.width / 5,
                                                                      height: context.width / 5,
                                                                      decoration: BoxDecoration(
                                                                        color: MyColor.colorWhite,
                                                                        borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                                        border: Border.all(color: MyColor.borderColor, width: 1),
                                                                      ),
                                                                      child: Center(
                                                                        child: SvgPicture.asset(
                                                                          MyIcons.doc,
                                                                          height: 45,
                                                                          width: 45,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      width: context.width / 5,
                                                                      height: context.width / 5,
                                                                      decoration: BoxDecoration(
                                                                        color: MyColor.colorWhite,
                                                                        borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                                        border: Border.all(color: MyColor.borderColor, width: 1),
                                                                      ),
                                                                      child: Center(
                                                                        child: SvgPicture.asset(
                                                                          MyIcons.pdfFile,
                                                                          height: 45,
                                                                          width: 45,
                                                                        ),
                                                                      ),
                                                                    ),
                                                    ),
                                                    CircleIconButton(
                                                      onTap: () {
                                                        controller.removeAttachmentFromList(index);
                                                      },
                                                      height: Dimensions.space20 + 5,
                                                      width: Dimensions.space20 + 5,
                                                      backgroundColor: MyColor.redCancelTextColor,
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: MyColor.colorWhite,
                                                        size: Dimensions.space15,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ZoomTapAnimation(
                                    onTap: () {
                                      if (controller.attachmentList.length < 5) {
                                        controller.pickFile();
                                      } else {
                                        CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.attactmentError], msg: [], isError: true);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space30),
                                      margin: const EdgeInsets.only(top: Dimensions.space5),
                                      width: context.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                        color: MyColor.textFieldColor,
                                      ),
                                      child: Column(
                                        children: [
                                          const Icon(Icons.attachment_rounded, color: MyColor.colorWhite),
                                          Text(MyStrings.chooseFile.tr, style: mulishLight.copyWith(color: MyColor.colorWhite)),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: Dimensions.space30),
                            controller.submitLoading
                                ? const RoundedLoadingButton()
                                : RoundedButton(
                                    text: MyStrings.reply.tr,
                                    press: () {
                                      controller.uploadTicketViewReply();
                                    },
                                  ),
                            const SizedBox(height: Dimensions.space30),
                          ],
                        ),
                      ),
                      controller.messageList.isEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space20),
                              decoration: BoxDecoration(
                                color: MyColor.bodyTextColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    MyStrings.noMSgFound.tr,
                                    style: mulishRegular.copyWith(color: MyColor.colorGrey),
                                  ),
                                ],
                              ))
                          : Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.messageList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => TicketViewCommentReplyModel(
                                  index: index,
                                  messages: controller.messageList[index],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}


//