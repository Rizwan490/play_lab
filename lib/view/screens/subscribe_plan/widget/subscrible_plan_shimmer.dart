import 'package:flutter/material.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/dimensions.dart';
import '../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';


class SubscribePlanShimmer extends StatelessWidget {
  const SubscribePlanShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index){

          return   Container(
            width: MediaQuery.of(context).size.width*0.6,
            margin: index==0?const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 35): const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:  MyColor.shimmerSplashColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),

            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5,),
               ClipRRect(
                 borderRadius: BorderRadius.circular(8),
                  child: const MyShimmerEffectUI.rectangular(height: 20,width: 140,),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: const MyShimmerEffectUI.rectangular(height: 30,width: 130,),
                      ),
                    ),
                    const SizedBox(width: 40,),
                    Expanded(child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const MyShimmerEffectUI.rectangular(height: 20,width: 140,),
                    ),)
                   ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
          )
          ;}
    );
  }
}
