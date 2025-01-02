import 'package:flutter/material.dart';
import '../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';


class WishlistShimmer extends StatelessWidget {
  final bool isShowCircle;
  const WishlistShimmer({super.key,this.isShowCircle=true});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index){
          return  Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: const MyShimmerEffectUI.rectangular(height: 150)
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       MyShimmerEffectUI.rectangular(height: 20,width: 100,),
                         SizedBox(
                          height: 10,
                        ),
                        MyShimmerEffectUI.rectangular(height: 20,width: 150,),
                         SizedBox(
                          height: 10,
                        ),
                        MyShimmerEffectUI.rectangular(height: 20,width: 80,), ],
                    ),

                    const Spacer(),
                    isShowCircle? const MyShimmerEffectUI.circular(height: 25,width: 25,):const SizedBox.shrink()

                  ],
                ),
                const SizedBox(height: 10,),
                const MyShimmerEffectUI.circular(height: 2,),
                const SizedBox(height: 10,)
              ],
            ),
          );}
    );
  }
}
