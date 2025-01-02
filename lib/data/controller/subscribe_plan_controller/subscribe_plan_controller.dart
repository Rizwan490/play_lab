import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:play_lab/constants/constant_helper.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/g_pay/local_verification_data.dart';
import 'package:play_lab/data/model/subscribe_plan/buy_subscribe_plan_response_model.dart';
import 'package:play_lab/data/model/subscribe_plan/subscribe_plan_response_model.dart';
import 'package:play_lab/data/repo/subscribe_plan_repo/subscribe_plan_repo.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class SubscribePlanController extends GetxController {
  SubscribePlanRepo repo;

  SubscribePlanController({required this.repo});

  String? nextPageUrl;
  bool isLoading = true;
  bool isBuyPlanClick = false;
  List<PlanModel> planList = [];
  int selectedIndex = -1;
  String portraitImagePath = '';

  String currency = '';

  int page = 0;

  Set<String> productKeys = <String>{}; //changed get productKys  from api

  void fetchInitialValue() async {
    updateStatus(true);
    page = 1;
    currency = repo.apiClient.getGSData().data?.generalSetting?.curText ?? '';
    print("repo.apiClient.isInappPurchaseAvalable() ${repo.apiClient.isInappPurchaseAvalable()}");
    await getPlanList();
    if (repo.apiClient.isInappPurchaseAvalable()) {
      observeInAppPurchase();
      print(productKeys.length);
      //get in app product list
      if (productKeys.isNotEmpty) {
        await loadInAppProducts(productKeys).then((value) {
          if (inapProducts.isNotEmpty) {
            checkAndUpdatePlanList();
          }
        });
      }
    }
    // combine in app product list with plan list

    updateStatus(false);
  }

  Future<void> getPlanList() async {
    ResponseModel model = await repo.getPlan(page: page);

    if (model.statusCode == 200) {
      SubscribePlanResponseModel responseModel = SubscribePlanResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.status?.toLowerCase() == "success") {
        List<PlanModel>? tempPlanList = responseModel.data?.data;
        portraitImagePath = responseModel.data?.image ?? '';
        List<String>? apCodes = responseModel.data?.appCode; // get product keys from api
        if (apCodes != null && apCodes.isNotEmpty) {
          productKeys.addAll(apCodes.toSet());
        }
        if (tempPlanList?.isNotEmpty == true) {
          if (page == 1) planList.clear();
          planList.addAll(tempPlanList!);
        }
        update();
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: responseModel.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      updateStatus(false);
    }
  }

  void checkAndUpdatePlanList() {
    List<PlanModel> tempList = [];
    for (var element in planList) {
      if (element.appCode != '') {
        PlanModel planModel = element;

        ProductDetails inAppProduct = inapProducts.firstWhere((product) => product.id.split('_')[1].toString() == element.id.toString(), orElse: () => ProductDetails(id: '-1', title: '', description: 'description', price: 'price', rawPrice: 0, currencyCode: 'currencyCode'));
        if (inAppProduct.id != '-1') {
          planModel.setInAppProduct(inAppProduct);
          tempList.add(planModel);
        }
      }
    }

    if (tempList.isNotEmpty && availableInAppPurchase == true) {
      planList.clear();
      planList.addAll(tempList);
    }
    update();
  }

  void fetchNewPlanList() async {
    page = page + 1;
    ResponseModel model = await repo.getPlan(page: page);

    if (model.statusCode == 200) {
      SubscribePlanResponseModel responseModel = SubscribePlanResponseModel.fromJson(jsonDecode(model.responseJson));
      List<PlanModel>? tempPlanList = responseModel.data?.data;
      // nextPageUrl = responseModel.data?.plans?.nextPageUrl;

      if (tempPlanList?.isNotEmpty == true) {
        planList.addAll(tempPlanList!);
      }
      update();
    }
  }

  updateStatus(bool status) {
    isLoading = status;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl != 'null' && nextPageUrl!.isNotEmpty ? true : false;
  }

  void clearAllData() {
    page = 0;
    isLoading = true;
    nextPageUrl = null;
    planList.clear();
  }

  int sIndex = -1;

  void buyPlan(int index) async {
    isBuyPlanClick = true;
    sIndex = index;
    update();
    if (await repo.canBuyPlan()) {
      try {
        ResponseModel response = await repo.buyPlan(planList[index].id?.toInt() ?? 0);
        if (response.statusCode == 200) {
          BuySubscribePlanResponseModel bModel = BuySubscribePlanResponseModel.fromJson(jsonDecode(response.responseJson));
          if (bModel.status == 'success') {
            isBuyPlanClick = false;
            String subId = bModel.data?.subscriptionId ?? '';
            update();
            Get.toNamed(RouteHelper.depositScreen, arguments: [planList[index].pricing, planList[index].name, subId, planList[index].id.toString()]);
          } else {
            CustomSnackbar.showCustomSnackbar(errorList: [bModel.message?.error.toString() ?? MyStrings.failedToBuySubscriptionPlan], msg: [''], isError: true);
          }
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: [response.message], msg: [], isError: true);
        }
      } catch (e) {
        PrintHelper.printHelper(e.toString());
      }
    }

    isBuyPlanClick = false;
    update();
  }

  List<ProductDetails> inapProducts = [];
  bool availableInAppPurchase = false;
  final iapConnection = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;

  handleError(IAPError error) {
    //
  }

  void observeInAppPurchase() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = iapConnection.purchaseStream;
    subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (Object error) {
      if (kDebugMode) {
        // print('subscription error ${error.toString()}');
      }
      // handle error here.
    });
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            sendPurchaseDetails(purchaseDetails);
          } else {
            // handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await iapConnection.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> loadInAppProducts(Set<String> keys) async {
    final bool available = await iapConnection.isAvailable();
    availableInAppPurchase = available;
    if (!available) {
      return;
    }
    update();

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = iapConnection.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    final ProductDetailsResponse response = await iapConnection.queryProductDetails(keys);
    if (response.notFoundIDs.isNotEmpty) {
      print("Subscription not found: ${response.notFoundIDs}");
    }
    List<ProductDetails> products = response.productDetails;
    if (products.isNotEmpty) {
      inapProducts.addAll(products);
    }
    // print('products.length ${products.length}');
    update();
  }

  PlanModel selectedPlanModel = PlanModel(id: -1);

  buyIAPProduct(PlanModel buyPlanModel) {
    selectedPlanModel = buyPlanModel;
    update();
    if (selectedPlanModel.id == -1) {
      return;
    } else {
      purchasePlane(selectedPlanModel);
    }
  }

  Future<void> purchasePlane(PlanModel plan) async {
    ProductDetails product = plan.inAppProduct!;
    if (!await repo.canBuyPlan()) {
      return;
    } else {
      try {
        final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
        final bool purchaseResult = await iapConnection.buyConsumable(purchaseParam: purchaseParam);
        if (!purchaseResult) {
          CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.subscriptionWasFailed], msg: [], isError: true);
        } else {}
      } catch (error) {
        // print('Error during Subscription: $error');
      }
    }
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetail) async {
    return Future<bool>.value(true);
  }

  Future<void> sendPurchaseDetails(PurchaseDetails purchaseDetail) async {
    await updateAdmin(purchaseDetail);
  }

  Future<void> updateAdmin(PurchaseDetails purchaseDetail) async {
    try {
      if (selectedPlanModel.id != -1) {
        LocalVerificationResponseModel vData = LocalVerificationResponseModel.fromJson(jsonDecode(purchaseDetail.verificationData.localVerificationData));

        ResponseModel responseModel = await repo.verifyPlan(
          productId: vData.productId.toString(),
          plan: selectedPlanModel,
          method: Platform.isAndroid ? '-1' : '-2',
          token: purchaseDetail.verificationData.serverVerificationData,
          purchaseCode: purchaseDetail.purchaseID.toString(),
          currency: selectedPlanModel.inAppProduct?.currencyCode.toString() ?? '',
          amount: selectedPlanModel.inAppProduct?.rawPrice.toString() ?? '0',
          packageName: vData.packageName ?? '',
        );
        if (responseModel.statusCode == 200) {
          AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
          if (model.status == "success") {
            buyIAPProduct(PlanModel(id: -1));
            CustomSnackbar.showCustomSnackbar(errorList: [], msg: model.message?.success ?? [], isError: false);
          } else {
            CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
          }
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
        }
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
