import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:play_lab/constants/my_strings.dart';

import '../../core/utils/dimensions.dart';
import '../../core/utils/my_color.dart';
import '../../core/utils/styles.dart';

class NoDataFoundScreen extends StatefulWidget {
  final String message;
  final double paddingTop;

  const NoDataFoundScreen({
    super.key,
    this.message = MyStrings.noDataFound,
    this.paddingTop = 6,
  });

  @override
  State<NoDataFoundScreen> createState() => _NoDataFoundScreenState();
}

class _NoDataFoundScreenState extends State<NoDataFoundScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width * .8,
                child: Lottie.asset('assets/animation/no_result.json', repeat: true, reverse: true, animate: true, height: height, width: width),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    widget.message.tr,
                    textAlign: TextAlign.center,
                    style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontExtraLarge),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
