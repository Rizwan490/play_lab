import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/movie_details_controller/movie_details_controller.dart';
import 'package:play_lab/data/repo/movie_details_repo/movie_details_repo.dart';
import 'package:play_lab/view/components/bottom-sheet/bottom_sheet_header_row.dart';

class CreatePartyBottomSheet extends StatefulWidget {
  final String itemId;
  final String episodeId;

  const CreatePartyBottomSheet({
    super.key,
    required this.itemId,
    required this.episodeId,
  });

  @override
  State<CreatePartyBottomSheet> createState() => _CreatePartyBottomSheetState();
}

class _CreatePartyBottomSheetState extends State<CreatePartyBottomSheet> {
  @override
  void initState() {
    Get.put(MovieDetailsRepo(apiClient: Get.find()));
    Get.put(MovieDetailsController(movieDetailsRepo: Get.find(), itemId: int.tryParse(widget.itemId) ?? -1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(builder: (controller) {
      return Column(
        children: [
          const BottomSheetHeaderRow(
            bottomSpace: 3,
          ),
          const SizedBox(height: Dimensions.space10),
          Container(
            padding: const EdgeInsets.only(
              bottom: Dimensions.space15,
              left: Dimensions.space10,
              right: Dimensions.space10,
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                const SizedBox(height: Dimensions.space10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColor.greenSuccessColor.withOpacity(0.2),
                  ),
                  child: Image.asset(MyImages.watchPartyImage, height: 40, width: 40, color: MyColor.greenSuccessColor),
                ),
                const SizedBox(height: Dimensions.space10),
                Text(MyStrings.watchParty.tr.toUpperCase(), style: mulishBold.copyWith(fontSize: 18, color: MyColor.colorWhite)),
                const SizedBox(height: Dimensions.space10),
                Text(
                  MyStrings.createPartySubText,
                  style: mulishLight.copyWith(color: MyColor.colorWhite),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.space20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: MyColor.red),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          MyStrings.cancel.tr.toUpperCase(),
                          style: mulishMedium.copyWith(color: MyColor.colorWhite),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Adjust spacing between buttons if needed
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: MyColor.greenSuccessColor),
                        onPressed: () {
                          if (controller.isCreatePartyLoading == false) {
                            controller.createParty(widget.episodeId, '', itemId: widget.itemId);
                          }
                        },
                        child: controller.isCreatePartyLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: MyColor.colorWhite),
                              )
                            : Text(
                                MyStrings.createParty.tr.toUpperCase(),
                                style: mulishMedium.copyWith(color: MyColor.colorWhite),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.space10),
              ],
            ),
          ),
        ],
      );
    });
  }
}
