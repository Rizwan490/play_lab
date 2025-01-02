import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'custom_shimmer_effect.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});


  @override
  Widget build(BuildContext context) {


    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white30,width: 1),
                borderRadius: BorderRadius.circular(8),
                color: MyColor.textFieldColor,
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(8),child:const MyShimmerEffectUI.rectangular(height: 20,width: 70,)),
            );});
  }
}
