import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/repo/watch_party/watch_party_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

class JoinPartyController extends GetxController {
  WatchPartyRepo repo;
  JoinPartyController({required this.repo});
  bool isLoading = false;
  TextEditingController partyController = TextEditingController();
  //
  Future<void> joinParty() async {
    if (partyController.text.isEmpty) {
      CustomSnackbar.showCustomSnackbar(errorList: ["Enter Your Party Code"], msg: [""], isError: true, duration: 1);
    }
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await repo.joinWatchParty(partyCode: partyController.text);
      if (responseModel.statusCode == 200) {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == MyStrings.success) {
          print(model.remark);
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: [model.message?.error.toString() ?? MyStrings.somethingWentWrong], msg: [], isError: true, duration: 2);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true, duration: 2);
      }
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true, duration: 2);
    } finally {
      isLoading = false;
      update();
    }
  }
}
