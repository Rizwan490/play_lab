import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/data/model/dashboard/user_subcription_response_model.dart';
import 'package:play_lab/data/model/global/telivision/telivision.dart';
import 'package:play_lab/data/model/subscribe_plan/buy_subscribe_plan_response_model.dart';
import 'package:play_lab/data/repo/live_tv_repo/live_tv_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import '../../model/global/response_model/response_model.dart';
import '../../model/live_tv/live_tv_response_model.dart';

class LiveTvController extends GetxController implements GetxService {
  LiveTvRepo repo;
  LiveTvController({required this.repo});

  bool isLoading = true;
  List<Telivison> televisionList = [];
  String televisionImagePath = '';
  int page = 0;
  String? nextPageUrl;
  String currency = '';
  String currencySym = '';

  void loadData() {
    getLiveTv();
    if (repo.apiClient.isAuthorizeUser()) {
      loadSubcriptionData();
    }
  }

  void getLiveTv() async {
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySym = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    clearAllData();
    page = 1;
    updateLoadingStatus(true);
    ResponseModel model = await repo.getLiveTv(page);
    if (model.statusCode == 200) {
      LiveTvResponseModel televisionModel = LiveTvResponseModel.fromJson(jsonDecode(model.responseJson));
      nextPageUrl = televisionModel.data?.televisions?.nextPageUrl ?? '';
      if (televisionModel.data != null) {
        if (televisionModel.data?.televisions?.data != null && televisionModel.data!.televisions!.data!.isNotEmpty) {
          televisionList.clear();
          televisionList.addAll(televisionModel.data!.televisions!.data!);
          televisionImagePath = televisionModel.data?.imagePath ?? '';
        }
        updateLoadingStatus(false);
      }
    } else {
      updateLoadingStatus(false);
    }
  }

  void getPaginateTV() async {
    page = page + 1;
    ResponseModel model = await repo.getLiveTv(page);
    if (model.statusCode == 200) {
      LiveTvResponseModel televisionModel = LiveTvResponseModel.fromJson(jsonDecode(model.responseJson));
      nextPageUrl = televisionModel.data?.televisions?.nextPageUrl ?? '';
      if (televisionModel.data != null) {
        if (televisionModel.data?.televisions?.data != null && televisionModel.data!.televisions!.data!.isNotEmpty) {
          televisionList.addAll(televisionModel.data!.televisions!.data!);
          televisionImagePath = televisionModel.data?.imagePath ?? '';
        }
      }
    }
  }

  List<String> subcribeChannelList = [];
  List<String> subcribeEventList = [];
  List<String> subcribeGameList = [];
  Future<void> loadSubcriptionData() async {
    printx('load all subcription id');
    ResponseModel responseModel = await repo.getSubcriptionData();

    if (responseModel.statusCode == 200) {
      UserSubcriptionResponseModel model = UserSubcriptionResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        subcribeChannelList.addAll(model.data?.subscribedChannelId ?? []);
        subcribeEventList.addAll(model.data?.subscribedTournamentId ?? []);
        subcribeGameList.addAll(model.data?.subscribedMatchId ?? []);
        update();
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  void clearAllData() {
    page = 0;
    isLoading = true;
    nextPageUrl = null;
    televisionList.clear();
  }

  void updateLoadingStatus(bool status) {
    isLoading = status;
    update();
  }

  String isSubcribeLoading = '-1';
  Future<void> subcribeNow(Telivison telivision) async {
    isSubcribeLoading = telivision.id.toString();
    update();
    try {
      ResponseModel response = await repo.subcribeChannel(telivision.id.toString());
      if (response.statusCode == 200) {
        BuySubscribePlanResponseModel bModel = BuySubscribePlanResponseModel.fromJson(jsonDecode(response.responseJson));
        if (bModel.status == 'success') {
          String subId = bModel.data?.subscriptionId ?? '';
          update();
          Get.toNamed(RouteHelper.depositScreen, arguments: [telivision.price.toString(), telivision.name.toString(), subId, telivision.id.toString()]);
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: [bModel.message?.error.toString() ?? MyStrings.failedToBuySubscriptionPlan], msg: [''], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
      }
    } catch (e) {
      printx(e.toString());
    }
    isSubcribeLoading = '-1';
    update();
  }
}
