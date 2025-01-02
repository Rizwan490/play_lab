import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';

class BottomSheetCloseButton extends StatelessWidget {
  const BottomSheetCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.space5),
        decoration: const BoxDecoration(color: MyColor.red, shape: BoxShape.circle),
        child: const Icon(Icons.clear, color: MyColor.colorWhite, size: 15),
      ),
    );
  }
}
