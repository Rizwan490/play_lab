import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:play_lab/core/utils/styles.dart';

import '../../../core/utils/dimensions.dart';

import '../../../core/utils/my_color.dart';

class CardColumn extends StatelessWidget {
  final String header;

  final String body;

  final bool alignmentEnd;

  final bool alignmentCenter;

  final bool isDate;

  final Color? textColor;

  String? subBody;

  TextStyle? headerTextDecoration;

  TextStyle? bodyTextDecoration;

  TextStyle? subBodyTextDecoration;

  bool? isOnlyHeader;

  bool? isonlyBody;

  final int bodyMaxLine;

  double? space = 5;

  CardColumn({super.key, this.bodyMaxLine = 1, this.alignmentEnd = false, this.alignmentCenter = false, required this.header, this.isDate = false, this.textColor, this.headerTextDecoration, this.bodyTextDecoration, required this.body, this.subBody, this.isOnlyHeader = false, this.isonlyBody = false, this.space});

  @override
  Widget build(BuildContext context) {
    return isOnlyHeader!
        ? Column(
            crossAxisAlignment: alignmentCenter
                ? CrossAxisAlignment.center
                : alignmentEnd
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Text(
                header.tr,
                style: headerTextDecoration ?? regularSmall.copyWith(color: Theme.of(context).textTheme.titleLarge!.color, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: space,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: alignmentCenter
                ? CrossAxisAlignment.center
                : alignmentEnd
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Text(
                header.tr,
                style: headerTextDecoration ?? regularSmall.copyWith(color: Theme.of(context).textTheme.titleLarge!.color?.withOpacity(0.6)),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: space,
              ),
              Text(
                body.tr,
                maxLines: bodyMaxLine,
                style: isDate ? mulishRegular.copyWith(fontStyle: FontStyle.italic, color: textColor ?? Theme.of(context).textTheme.titleLarge!.color, fontSize: Dimensions.fontSmall) : bodyTextDecoration ?? regularSmall.copyWith(color: textColor ?? Theme.of(context).textTheme.titleLarge!.color, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: space,
              ),
              subBody != null
                  ? Text(subBody!.tr, maxLines: bodyMaxLine, style: isDate ? mulishRegular.copyWith(fontStyle: FontStyle.italic, color: textColor ?? MyColor.getTextColor(), fontSize: Dimensions.fontSmall) : subBodyTextDecoration ?? regularSmall.copyWith(color: textColor ?? MyColor.getTextColor().withOpacity(0.5), fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
                  : const SizedBox.shrink()
            ],
          );
  }
}
