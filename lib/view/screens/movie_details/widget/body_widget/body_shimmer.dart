import 'package:flutter/material.dart';

import '../../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';


class MovieDetailsShimmer extends StatelessWidget {
  const MovieDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(8),child:
              const MyShimmerEffectUI.rectangular(height: 20,width: 120,)
              ),
              const SizedBox(width: 15,),
              ClipRRect(borderRadius: BorderRadius.circular(8),child:
              const MyShimmerEffectUI.rectangular(height: 20,width: 120,)
              ),

            ],
          ),
        ),

        const SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child:
          ClipRRect(borderRadius: BorderRadius.circular(8),child:
           MyShimmerEffectUI.rectangular(height: 80,width: MediaQuery.of(context).size.width*0.7,)
          ),
        ),

      ],
    );
  }
}
