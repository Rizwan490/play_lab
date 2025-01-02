import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../core/utils/dimensions.dart';
import '../row_item/header_row.dart';

class ShowMoreText extends StatelessWidget {

  final String headerText;
  final Callback press;
  final bool isShowMoreVisible;

  const ShowMoreText({
    super.key,
    this.isShowMoreVisible=true,
    required this.headerText,
    required this.press
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin,right: Dimensions.homePageRightMargin),
      child: HeaderRow(isShowMoreVisible:isShowMoreVisible,heading: headerText, onShowMorePress: press),
    );
  }
}
