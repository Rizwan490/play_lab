import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/date_converter.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/watch_party_controller/watch_party_history_controller.dart';
import 'package:play_lab/data/model/party_room/party_history_response_model.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

class PartyHistoryCard extends StatelessWidget {
  Party party;
  WatchPartyHistoryController controller;
  PartyHistoryCard({
    super.key,
    required this.party,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.borderColor, width: .4),
        borderRadius: BorderRadius.circular(Dimensions.cardRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    MyImages.filmImage,
                    height: 16,
                    width: 16,
                    color: MyColor.colorWhite,
                  ),
                  const SizedBox(width: Dimensions.space10),
                  Text(
                    party.item?.title ?? '',
                    style: mulishBold.copyWith(color: MyColor.colorWhite),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    MyImages.people,
                    colorFilter: const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn),
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    (party.partyMember?.length.toString() ?? '').padLeft(2, '0'),
                    style: mulishBold.copyWith(color: MyColor.colorWhite),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: Dimensions.space10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        party.partyCode.toString().toUpperCase(),
                        style: mulishBold.copyWith(color: MyColor.primaryColor),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: party.partyCode.toString().toUpperCase())).then(
                            (value) {
                              CustomSnackbar.showCustomSnackbar(
                                errorList: [],
                                msg: ["${MyStrings.successfullyCopiedToClipboard} ${party.partyCode.toString().toUpperCase()}"],
                                isError: false,
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.copy,
                          color: MyColor.colorWhite,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Text(
                    DateConverter.estimatedDate(DateConverter.convertStringToDatetime(party.createdAt ?? "")),
                    style: mulishRegular.copyWith(color: MyColor.colorWhite, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space5, vertical: Dimensions.space5 - 3),
                decoration: BoxDecoration(
                  color: controller.getStatusColor(party.status.toString()),
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                ),
                child: Text(
                  controller.getStatus(party.status.toString()),
                  style: mulishBold.copyWith(color: MyColor.colorWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
