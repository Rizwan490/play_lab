import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';

import '../../../constants/my_strings.dart';
import '../../../core/helper/string_format_helper.dart';
import '../../../core/route/route.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/deposit/insert_deposit_response_model.dart';
import '../../model/deposit/main_deposit_method_response_model.dart';
import '../../model/general_setting/general_settings_response_model.dart';
import '../../repo/deposit_repo/deposit_repo.dart';

import 'package:in_app_purchase/in_app_purchase.dart';

class AddNewDepositController extends GetxController {
  DepositRepo depositRepo;
  TextEditingController amountController = TextEditingController();
  bool isLoading = false;
  String subId = '';
  AddNewDepositController({required this.depositRepo, required this.subId});

  GeneralSettingsResponseModel model = GeneralSettingsResponseModel();
  String currency = '';

  Methods? paymentMethod = Methods();

  MainDepositMethodResponseModel depositMethodResponseModel = MainDepositMethodResponseModel();
  List<Methods> paymentMethodList = [];

  String depositLimit = '';
  String charge = '';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';
  double rate = 1;
  double mainAmount = 0;

  setPaymentMethod(Methods? method, String price) {
    paymentMethod = method;
    String amt = price;
    mainAmount = amt.isEmpty ? 0 : double.tryParse(amt) ?? 0;
    depositLimit = '${StringConverter.twoDecimalPlaceFixedWithoutRounding(method?.minAmount?.toString() ?? '-1')} - ${StringConverter.roundDoubleAndRemoveTrailingZero(method?.maxAmount?.toString() ?? '-1')} $currency';
    charge = '${StringConverter.twoDecimalPlaceFixedWithoutRounding(method?.fixedCharge?.toString() ?? '0')} + ${StringConverter.twoDecimalPlaceFixedWithoutRounding(method?.percentCharge?.toString() ?? '0')} %';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  void changeInfoWidgetValue(double amount) {
    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge ?? '0') ?? 0;
    double percentCharge = (amount * percent) / 100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge ?? '0') ?? 0;
    double totalCharge = percentCharge + temCharge;
    charge = '${StringConverter.twoDecimalPlaceFixedWithoutRounding('$totalCharge')} $currency';
    double payable = totalCharge + amount;
    payableText = '${StringConverter.twoDecimalPlaceFixedWithoutRounding('$payable')} $currency';

    rate = double.tryParse(paymentMethod?.rate ?? '0') ?? 0;
    conversionRate = '1 $currency = $rate ${paymentMethod?.currency ?? ''}';
    inLocal = StringConverter.twoDecimalPlaceFixedWithoutRounding('${payable * rate}');
    update();
    return;
  }

  beforeInitLoadData(String price) async {
    setStatusTrue();
    model = depositRepo.apiClient.getGSData();
    currency = model.data?.generalSetting?.curText ?? '';
    depositMethodResponseModel = await depositRepo.getDepositMethod();
    paymentMethodList.clear();

    if (depositMethodResponseModel.code == 200) {
      List<Methods>? l = depositMethodResponseModel.data?.methods;
      if (l != null && l.isNotEmpty) {
        paymentMethodList.addAll(l);
      }
      if (paymentMethodList.isNotEmpty) {
        try {
          paymentMethod = paymentMethodList[0];
          setPaymentMethod(paymentMethod, price);
        } catch (e) {
          e.printError();
        }
      }
      setStatusFalse();
    } else {
      //fail
      setStatusFalse();
    }
  }

  void submitDeposit(String price) async {
    String amount = price;
    if (amount.isEmpty) {
      return;
    }
    double amount1 = 0;
    double maxAmount = 0;
    try {
      amount1 = double.parse(amount);
      maxAmount = double.parse(paymentMethod?.maxAmount ?? '0');
    } catch (e) {
      return;
    }

    if (maxAmount == 0 || amount1 == 0) {
      List<String> errorList = [MyStrings.invalidAmount];
      CustomSnackbar.showCustomSnackbar(errorList: errorList, msg: [], isError: true);
      return;
    }

    setStatusTrue();

    InsertDepositResponseModel mo = await depositRepo.insertDeposit(subId, amount1, paymentMethod?.methodCode, paymentMethod?.currency);

    if (mo.status != MyStrings.success) {
      List<String> error = [];
      if (mo.status != 'success') {
        List<String>? list = mo.message?.error ?? [MyStrings.somethingWentWrong];
        error.addAll(list);
      } else {
        error.add(MyStrings.somethingWentWrong);
      }
      CustomSnackbar.showCustomSnackbar(errorList: error, msg: [''], isError: true);
      setStatusFalse();
    } else {
      String redirectUrl = mo.data?.redirectUrl ?? '';
      if (redirectUrl.isEmpty) {
        List<String> error = [MyStrings.invalidPaymentUrl];
        CustomSnackbar.showCustomSnackbar(errorList: error, msg: [''], isError: false);
      } else {
        amountController.text = '';
        showWebView(redirectUrl);
      }
      setStatusFalse();
    }
  }

  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
  }

  void clearData() {
    depositLimit = '';
    charge = '';
    paymentMethodList.clear();
    amountController.text = '';
    setStatusFalse();
  }

  void showWebView(String redirectUrl) {
    Get.toNamed(RouteHelper.customWebviewScreen, arguments: redirectUrl);
  }

  bool isGooglePayLoading = false;
  void configureGoogleInAppPayment(Map<String, dynamic> result, String price) async {
    String token = '';
    String cardHolderName = 'ddd';
    try {
      token = result['paymentMethodData']['tokenizationData']['token'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    String methodCode = '-1';
    String amount = price;

    isGooglePayLoading = true;
    update();

    ResponseModel model = await depositRepo.sendManualPaymentRequest(token, methodCode, amount, planId, cardHolderName);

    if (model.statusCode == 200) {
      AuthorizationResponseModel model1 = AuthorizationResponseModel.fromJson(jsonDecode(model.responseJson));
      if (model1.status?.toLowerCase() == 'success') {
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model1.message?.success ?? [MyStrings.success], isError: false);
        Get.offAndToNamed(RouteHelper.paymentHistoryScreen);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [model1.message?.error.toString() ?? MyStrings.requestFailed], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
    }

    isGooglePayLoading = false;
    update();
  }

  bool isApplePayLoading = false;
  void configureAppleInAppPayment(Map<String, dynamic> result, String price) async {
    String token = '';
    String cardHolderName = '---';
    try {
      token = result['paymentMethodData']['tokenizationData']['token'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    String methodCode = '-2';
    String amount = price;

    isApplePayLoading = true;
    update();

    ResponseModel model = await depositRepo.sendManualPaymentRequest(token, methodCode, amount, planId, cardHolderName);

    if (model.statusCode == 200) {
      AuthorizationResponseModel model1 = AuthorizationResponseModel.fromJson(jsonDecode(model.responseJson));
      if (model1.status?.toLowerCase() == 'success') {
        CustomSnackbar.showCustomSnackbar(errorList: [], msg: model1.message?.success ?? [MyStrings.success], isError: false);
        Get.offAndToNamed(RouteHelper.paymentHistoryScreen);
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [model1.message?.error.toString() ?? MyStrings.requestFailed], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
    }

    isApplePayLoading = false;
    update();
  }

  String planId = '';
  void setPlanId(String planId) {
    this.planId = planId;
    update();
  }

  //
}

// Gives the option to override in tests.
class IAPConnection {
  static InAppPurchase? _instance;
  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}
