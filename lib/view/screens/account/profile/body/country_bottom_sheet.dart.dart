import 'package:flutter/material.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/controller/account/profile_controller.dart';
import 'package:play_lab/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:play_lab/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';

class CountryBottomSheet {
  static void showProfileCompleteBottomSheet(BuildContext context, ProfileController controller) {
    CustomBottomSheet(
      bgColor: MyColor.transparentColor,
      isNeedMargin: true,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          if (controller.filteredCountries.isEmpty) {
            controller.filteredCountries = controller.countryList;
          }
          // Function to filter countries based on the search input.
          void filterCountries(String query) {
            if (query.isEmpty) {
              controller.filteredCountries = controller.countryList;
            } else {
              setState(() {
                controller.filteredCountries = controller.countryList.where((country) => country.country!.toLowerCase().contains(query.toLowerCase())).toList();
              });
            }
          }

          return Container(
            height: MediaQuery.of(context).size.height * .7,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: const BoxDecoration(
              color: MyColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const BottomSheetHeaderRow(header: '', bottomSpace: 15),

                // Add the search field.
                TextField(
                  controller: controller.searchCountryController,
                  onChanged: filterCountries,
                  decoration: const InputDecoration(
                    hintText: MyStrings.searchCountry,
                    hintStyle: mulishRegular,
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyColor.colorWhite,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: MyColor.borderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: MyColor.primaryColor),
                    ),
                  ),
                  cursorColor: MyColor.primaryColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var countryItem = controller.filteredCountries[index];

                        return GestureDetector(
                          onTap: () {
                            controller.setCountryNameAndCode(
                              controller.filteredCountries[index].country.toString(),
                              controller.filteredCountries[index].countryCode.toString(),
                              controller.filteredCountries[index].dialCode.toString(),
                            );
                            controller.updateMobilecode(controller.filteredCountries[index].dialCode.toString());
                            controller.selectCountryData(controller.filteredCountries[index]);
                            Navigator.pop(context);
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            controller.mobileNoFocusNode.nextFocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: MyColor.transparentColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: MyColor.colorGrey.withOpacity(0.3),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: MyImageWidget(
                                    imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", countryItem.countryCode.toString().toLowerCase()),
                                    height: Dimensions.space20 + 5,
                                    width: Dimensions.space50 - 8,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                  child: Text(
                                    '+${countryItem.dialCode}',
                                    style: mulishRegular.copyWith(color: MyColor.primaryColor),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${countryItem.country}',
                                    style: mulishRegular.copyWith(color: MyColor.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        },
      ),
    ).customBottomSheet(context);
  }
}
