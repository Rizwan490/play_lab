import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/model/auth/error_model.dart';

import 'validation_chip_widget.dart';

class ValidationWidget extends StatelessWidget {
  final List<ErrorModel> list;
  final double heightBottom;

  const ValidationWidget({super.key, required this.list, this.heightBottom = 10});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        Wrap(
          children: list
              .map(
                (item) => ChipWidget(
                  name: item.text.tr,
                  hasError: item.hasError,
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: heightBottom,
        )
      ],
    );
  }
}
