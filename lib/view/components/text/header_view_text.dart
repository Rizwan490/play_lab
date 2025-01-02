import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../row_item/header_row.dart';

class HeaderViewText extends StatelessWidget {

  final String header;
  final bool isShowMoreVisible;

  const HeaderViewText({
    super.key,
    required this.header,
    this.isShowMoreVisible=true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin,right: Dimensions.homePageRightMargin),
      child: HeaderRow(
          isShowMoreVisible:isShowMoreVisible,
          heading: header.tr,
          onShowMorePress: (){}
      ),
    );
  }
}
