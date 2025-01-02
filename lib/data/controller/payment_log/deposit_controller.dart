import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:play_lab/data/model/deposit/deposit_history_main_response_model.dart';
import '../../repo/deposit_repo/deposit_repo.dart';

class DepositController extends GetxController implements GetxService {
  DepositRepo depositRepo;
  DepositController({required this.depositRepo});
  bool isLoading = false;

  DepositHistoryMainResponseModel depositModel = DepositHistoryMainResponseModel();
  String currency = '';
  List<HistoryData> depositList = [];
  String? nextPageUrl = '';
  String trx = '';

  int page = 1;
  beforeInitLoadData() async {
    isLoading = true;
    update();

    currency = depositRepo.apiClient.getGSData().data?.generalSetting?.curText ?? '';
    page = 1;
    depositModel = await depositRepo.loadAllDepositHistory(page);
    depositList.clear();
    List<HistoryData>? tempDepositList = depositModel.mainData?.deposits?.data;
    nextPageUrl = depositModel.mainData?.deposits?.nextPageUrl ?? '';
    if (tempDepositList != null && tempDepositList.isNotEmpty) {
      depositList.addAll(tempDepositList);
    }

    isLoading = false;
    update();
  }

  int totalPage = 0;
  void fetchNewList() async {
    page = page + 1;
    depositModel = await depositRepo.loadAllDepositHistory(
      page,
    );
    List<HistoryData>? tempDepositList = depositModel.mainData?.deposits?.data;
    nextPageUrl = depositModel.mainData?.deposits?.nextPageUrl ?? '';
    if (tempDepositList != null && !(tempDepositList == [])) {
      depositList.addAll(tempDepositList);
    }
    update();
  }

  bool hasNext() {
    if (nextPageUrl != null && nextPageUrl!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void clearData() {
    nextPageUrl = '';
    depositList.clear();
    isLoading = false;
  }

  void setTrx(value) {
    trx = value;
  }
}
