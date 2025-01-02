import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../.././../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../data/controller/category/category_controller/category_controller.dart';
import '../../shimmer/category_shimmer.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        builder: (controller) => controller.isLoading
            ? const SizedBox(height: 50, child: CategoryShimmer())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: Dimensions.homePageLeftMargin),
                child: Row(
                  children: List.generate(
                      controller.categoryList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.subCategoryScreen, arguments: [controller.categoryList[index].id, controller.categoryList[index].name ?? '']);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                                color: MyColor.t4,
                                // border: Border.all(color: Colors.white30,width: 1),
                              ),
                              child: Text(
                                controller.categoryList[index].name?.tr ?? '',
                                style: mulishSemiBold.copyWith(color: MyColor.t2),
                              ),
                            ),
                          )),
                ),
              ));
  }
}
