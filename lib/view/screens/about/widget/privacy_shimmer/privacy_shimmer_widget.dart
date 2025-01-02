import 'package:flutter/material.dart';

import '../../../bottom_nav_pages/home/shimmer/category_shimmer.dart';
import '../../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';


class PrivacyPolicyShimmer extends StatefulWidget {
  const PrivacyPolicyShimmer({super.key});

  @override
  State<PrivacyPolicyShimmer> createState() => _PrivacyPolicyShimmerState();
}

class _PrivacyPolicyShimmerState extends State<PrivacyPolicyShimmer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height:50,child: CategoryShimmer()),
          const SizedBox(height: 20,),
         ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const MyShimmerEffectUI.rectangular(height: 20,width: 120,),
          ),
          const SizedBox(height: 15,),
         const Expanded(child: SizedBox(height:350,child: MyShimmerEffectUI.rectangular(height: 300,)))
        ],
      ),
    );
  }
}
