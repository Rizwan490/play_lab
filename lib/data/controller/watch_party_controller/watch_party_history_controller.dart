import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/controller/pusher_controller/pusher_history_helper_controller.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/party_room/join_party_response_model.dart';
import 'package:play_lab/data/model/party_room/party_history_response_model.dart';
import 'package:play_lab/data/repo/watch_party/watch_party_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class WatchPartyHistoryController extends GetxController {
  WatchPartyRepo repo;
  WatchPartyHistoryPusherController pushController;
  WatchPartyHistoryController({
    required this.repo,
    required this.pushController,
  });

  bool isLoading = false;
  List<Party> partyList = [];
  int currentPage = 0;
  String? nextPageUrl;
  String userId = '';
  TextEditingController partyCodeController = TextEditingController();

  void loadData() async {
    currentPage = 0;
    partyList.clear();
    nextPageUrl = null;
    partyCodeController.text = '';
    userId = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIDKey) ?? '';
    update();
    pushController.subscribePusher();
    await getPartyHistory();
  }

  Color getStatusColor(String status) {
    if (status == "1") {
      return MyColor.greenSuccessColor;
    } else {
      return MyColor.redCancelTextColor;
    }
  }

  String getStatus(String status) {
    if (status == "1") {
      return MyStrings.running;
    } else {
      return MyStrings.canceled;
    }
  }

  Future<void> getPartyHistory() async {
    currentPage = currentPage + 1;
    if (currentPage == 1) {
      partyList.clear();
      isLoading = true;
      update();
    }

    try {
      ResponseModel responseModel = await repo.getPartyHistory(page: currentPage.toString());
      if (responseModel.statusCode == 200) {
        PartyHistoryResponseModel model = PartyHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == MyStrings.success) {
          nextPageUrl = model.data?.parties?.nextPageUrl;
          update();
          List<Party>? tempPartyList = model.data?.parties?.data;
          if (tempPartyList != null && tempPartyList.isNotEmpty) {
            partyList.addAll(tempPartyList);
            update();
          }
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.watchPartyErrorMsg], msg: [], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
      }
    } catch (e) {
      print(e.toString());
      CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }

  bool isJoinPartyBtnLoading = false;

  Future<void> joinPartyRequest() async {
    try {
      isJoinPartyBtnLoading = true;
      update();
      ResponseModel responseModel = await repo.joinWatchParty(partyCode: partyCodeController.text);
      if (responseModel.statusCode == 200) {
        JoinPartyResponseModel model = JoinPartyResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == MyStrings.success) {
          Get.back(); // back for bottom sheet
        } else {
          if (model.remark == "already_joined" && model.data != null) {
            Get.toNamed(
              RouteHelper.watchPartyRoomScreen,
              arguments: [
                model.data?.partyRoom?.partyCode ?? '',
                userId,
              ],
            );
          } else {
            CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [""], msg: [], isError: true);
          }
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
      }
    } catch (e) {
      print(e.toString());
      // CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true);
    } finally {
      isJoinPartyBtnLoading = false;
      update();
    }
  }

  clearInputFiled() {
    partyCodeController.text = "";
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  Stream<PusherEvent> listenPusherEventStream() {
    return pushController.eventStream;
  }

  //
}
