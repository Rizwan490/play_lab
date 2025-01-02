import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/view/components/buttons/category_button.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/dialog/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/data/controller/my_search_controller/search_controller.dart';
import 'package:play_lab/data/repo/my_search/my_search_repo.dart';
import '../../../components/dialog/subscribe_now_dialog.dart';
import '../../bottom_nav_pages/home/widget/custom_network_image/custom_network_image.dart';
import 'package:play_lab/view/screens/movie_details/widget/rating_and_watch_widget/RatingAndWatchWidget.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../bottom_nav_pages/home/shimmer/grid_shimmer.dart';

class SearchResultListWidget extends StatefulWidget {
  final String searchText;
  final int categoryId;
  final int subCategoryId;
  const SearchResultListWidget({super.key, this.searchText = '', this.categoryId = -1, this.subCategoryId = -1});

  @override
  State<SearchResultListWidget> createState() => _SearchResultListWidgetState();
}

class _SearchResultListWidgetState extends State<SearchResultListWidget> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<MySearchController>().fetchSubCategoryData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<MySearchController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(MySearchRepo(apiClient: Get.find()));
    MySearchController controller = Get.put(MySearchController(repo: Get.find(), searchText: widget.searchText, subCategoryId: widget.subCategoryId, categoryId: widget.categoryId));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchText = widget.searchText;
      controller.fetchInitialSubCategoryData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<MySearchController>().changeSubCategoryId(widget.subCategoryId);
    return GetBuilder<MySearchController>(
      builder: (controller) => controller.isLoading
          ? const Flexible(child: GridShimmer())
          : controller.movieList.isEmpty
              ? const Flexible(child: NoDataFoundScreen())
              : Flexible(
                  child: AnimationLimiter(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        controller: _controller,
                        itemCount: controller.movieList.length + 1,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: Dimensions.gridViewCrossAxisSpacing, mainAxisSpacing: Dimensions.gridViewMainAxisSpacing, crossAxisCount: 3, childAspectRatio: .55),
                        itemBuilder: (context, index) {
                          if (index == controller.movieList.length) {
                            return controller.hasNext()
                                ? const Center(
                                    child: SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: CircularProgressIndicator(
                                        color: MyColor.primaryColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 1200),
                            columnCount: 3,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: SizedBox(
                                  child: GestureDetector(
                                    onTap: () {
                                      bool isFree = controller.movieList[index].version == '0' ? true : false;
                                      bool isPaid = controller.movieList[index].version == '1' ? true : false;
                                      bool isPaidUser = controller.repo.apiClient.isPaidUser();
                                      if (controller.isGuest() && isFree == false) {
                                        showLoginDialog(context);
                                      } else if (!isPaidUser && isFree == false && isPaid == true) {
                                        showSubscribeDialog(context);
                                      } else {
                                        Get.toNamed(RouteHelper.movieDetailsScreen, arguments: [controller.movieList[index].id, -1]);
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Expanded(
                                                child: ClipRRect(
                                              borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                                              child: CustomNetworkImage(
                                                imageUrl: '${UrlContainer.baseUrl}assets/images/item/portrait/${controller.movieList[index].image?.portrait}',
                                                height: 160,
                                              ),
                                            )),
                                            const SizedBox(height: 7),
                                            Text(controller.movieList[index].title?.tr ?? '', style: mulishSemiBold.copyWith(color: MyColor.colorWhite, overflow: TextOverflow.ellipsis)),
                                            SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: RatingAndWatchWidget(
                                                  textColor: MyColor.primaryText2,
                                                  iconSpace: 4,
                                                  rating: StringConverter.twoDecimalPlaceFixedWithoutRounding(controller.movieList[index].ratings ?? '0'),
                                                  watch: StringConverter.twoDecimalPlaceFixedWithoutRounding(controller.movieList[index].view ?? '0', precision: 0),
                                                  iconSize: 14,
                                                  textSize: Dimensions.fontExtraSmall,
                                                ))
                                          ],
                                        ),
                                        CategoryButton(
                                          text: controller.movieList[index].version == '0'
                                              ? MyStrings.free
                                              : controller.movieList[index].version == '1'
                                                  ? MyStrings.paid
                                                  : MyStrings.rent,
                                          press: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
    );
  }
}
