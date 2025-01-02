import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/my_search_controller/search_controller.dart';
import 'package:play_lab/data/repo/my_search/my_search_repo.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/no_data_widget.dart';
import 'package:play_lab/view/components/app_bar/custom_appbar.dart';
import 'package:play_lab/view/screens/sub_category/widget/search_result_widget.dart';

import '../../../constants/my_strings.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen({super.key, required this.searchText});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MySearchRepo(apiClient: Get.find()));
    Get.put(MySearchController(repo: Get.find(), searchText: widget.searchText));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: MyColor.colorBlack,
                appBar: const CustomAppBar(title: MyStrings.searchResult),
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: !controller.isLoading && controller.movieList.isEmpty
                      ? const NoDataFoundScreen()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SearchResultListWidget(
                              searchText: widget.searchText,
                            ),
                          ],
                        ),
                ),
              ),
            ));
  }
}
