import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/model/dashboard/dashboard_response_model.dart';
import 'package:play_lab/view/screens/bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';

class TrailerCard extends StatelessWidget {
  Featured trailer;
  String trailerImagePath;
  TrailerCard({
    super.key,
    required this.trailer,
    required this.trailerImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [trailer.id, -1]);
      },
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomNetworkImage(
                imageUrl: '${UrlContainer.baseUrl}$trailerImagePath/${trailer.image?.portrait}',
                width: 105,
                height: 160,
                boxFit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: Dimensions.spaceBetweenTextAndImage,
            ),
            Text(
              trailer.title?.tr ?? '',
              style: mulishSemiBold.copyWith(color: MyColor.colorWhite, fontSize: Dimensions.fontSmall, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
