
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../components/row_item/header_row.dart';

class ShowMoreRowWidget extends StatelessWidget {
  final String value;
  final Callback press;
  final bool isShowMoreVisible;
  const ShowMoreRowWidget({super.key,this.isShowMoreVisible=true, required this.value,required this.press});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
        left: Dimensions.homePageLeftMargin,
        right: Dimensions.homePageRightMargin),
    child: HeaderRow(heading: value,isShowMoreVisible: isShowMoreVisible, onShowMorePress: press));
  }
}
