import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/helper/shared_pref_helper.dart';
import 'package:play_lab/core/helper/string_format_helper.dart';
import 'package:play_lab/data/controller/support/support_controller.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/support/support_ticket_view_response_model.dart';
import 'package:play_lab/data/repo/support/support_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

import '../../../core/utils/my_color.dart';

class TicketDetailsController extends GetxController {
  SupportRepo repo;
  final String ticketId;
  String username = '';
  bool isRtl = false;

  TicketDetailsController({required this.repo, required this.ticketId});

  loadData() async {
    isLoading = true;
    update();
    String languageCode = repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.langCode) ?? 'eng';
    if (languageCode == 'ar') {
      isRtl = true;
    }
    loadUserName();
    await loadTicketDetailsData();
    isLoading = false;
    update();
  }

  void loadUserName() {
    username = repo.apiClient.getCurrencyOrUsername(isCurrency: false);
  }

  bool isLoading = false;

  final TextEditingController replyController = TextEditingController();

  MyTickets? receivedTicketModel;
  List<File> attachmentList = [];

  String noFileChosen = MyStrings.noFileChosen;
  String chooseFile = MyStrings.chooseFile;

  String ticketImagePath = "";

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);
    if (result == null) return;

    attachmentList.add(File(result.files.single.path!));

    update();
  }

  bool isImage(String path) {
    if (path.contains('.jpg')) {
      return true;
    }
    if (path.contains('.png')) {
      return true;
    }
    if (path.contains('.jpeg')) {
      return true;
    }
    return false;
  }

  bool isXlsx(String path) {
    if (path.contains('.xlsx')) {
      return true;
    }
    if (path.contains('.xls')) {
      return true;
    }
    if (path.contains('.xlx')) {
      return true;
    }
    return false;
  }

  bool isDoc(String path) {
    if (path.contains('.doc')) {
      return true;
    }
    if (path.contains('.docs')) {
      return true;
    }
    return false;
  }

  removeAttachmentFromList(int index) {
    if (attachmentList.length > index) {
      attachmentList.removeAt(index);
      update();
    }
  }

  SupportTicketViewResponseModel model = SupportTicketViewResponseModel();
  List<SupportMessage> messageList = [];
  String ticket = '';
  String subject = '';
  String status = '-1';
  String ticketName = '';

  Future<void> loadTicketDetailsData({bool shouldLoad = true}) async {
    isLoading = shouldLoad;
    update();
    ResponseModel response = await repo.getSingleTicket(ticketId);

    if (response.statusCode == 200) {
      model = SupportTicketViewResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        ticket = model.data?.myTickets?.ticket ?? '';
        subject = model.data?.myTickets?.subject ?? '';
        status = model.data?.myTickets?.status ?? '';
        ticketName = model.data?.myTickets?.name ?? '';
        receivedTicketModel = model.data?.myTickets;
        List<SupportMessage>? tempTicketList = model.data?.myMessages;
        if (tempTicketList != null && tempTicketList.isNotEmpty) {
          messageList.clear();
          messageList.addAll(tempTicketList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], isError: true, msg: []);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [response.message], isError: true, msg: []);
    }

    isLoading = false;
    update();
  }

  bool submitLoading = false;
  Future<void> uploadTicketViewReply() async {
    if (replyController.text.toString().isEmpty) {
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.replyTicketEmptyMsg], isError: true, msg: []);
      return;
    }
    submitLoading = true;
    update();

    try {
      bool b = await repo.replyTicket(replyController.text, attachmentList, receivedTicketModel?.id.toString() ?? "-1");

      if (b) {
        await loadTicketDetailsData(shouldLoad: false);
        CustomSnackbar.showCustomSnackbar(msg: [MyStrings.repliedSuccessfully], errorList: [], isError: false);
        replyController.text = '';
        refreshAttachmentList();
      }
    } catch (e) {
      submitLoading = false;
      update();
    } finally {
      submitLoading = false;
      update();
    }
  }

  setTicketModel(MyTickets? ticketModel) {
    receivedTicketModel = ticketModel;
    update();
  }

  void clearAllData() {
    refreshAttachmentList();
    replyController.clear();
    messageList.clear();
  }

  void refreshAttachmentList() {
    attachmentList.clear();
    update();
  }

  bool closeLoading = false;
  void closeTicket(String supportTicketID) async {
    closeLoading = true;
    update();
    ResponseModel responseModel = await repo.closeTicket(supportTicketID);
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        print(model.status);
        clearAllData();
        Get.back();
        CustomSnackbar.showCustomSnackbar(msg: model.message?.success ?? [MyStrings.requestSuccess], errorList: [], isError: false);
        Get.find<SupportController>().loadData();
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.requestFailed], isError: true, msg: []);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], isError: true, msg: []);
    }

    closeLoading = false;
    update();
  }

  String getStatusText(String priority, {bool isPriority = false, bool isStatus = false}) {
    String text = '';
    text = priority == '0'
        ? MyStrings.open.tr
        : priority == '1'
            ? MyStrings.answered.tr
            : priority == '2'
                ? MyStrings.replied.tr
                : priority == '3'
                    ? MyStrings.closed.tr
                    : '';
    return text;
  }

  Color getStatusColor(String status, {bool isPriority = false}) {
    late Color output;
    if (isPriority) {
      output = status == '1'
          ? MyColor.pendingColor
          : status == '2'
              ? MyColor.greenSuccessColor
              : status == '3'
                  ? MyColor.redCancelTextColor
                  : MyColor.pendingColor;
    } else {
      output = status == '1'
          ? MyColor.colorGrey
          : status == '2'
              ? MyColor.highPriorityPurpleColor
              : status == '3'
                  ? MyColor.redCancelTextColor
                  : MyColor.greenSuccessColor;
    }

    return output;
  }

  //download pdf
  TargetPlatform? platform;
  String _localPath = '';
  String downLoadId = "";

  Future<bool> checkPermission() async {
    if (platform == TargetPlatform.android) {
      await Permission.storage.request();
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        await Permission.storage.request();
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        return directory.path;
      } else {
        return (await getExternalStorageDirectory())?.path ?? "";
      }
    } else if (Platform.isIOS) {
      return (await getApplicationDocumentsDirectory()).path;
    } else {
      return null;
    }
  }

  bool isSubmitLoading = false;
  int selectedIndex = -1;

  Future<void> downloadAttachment(String url, int index, String extention) async {
    printx("selectedIndex $selectedIndex");

    selectedIndex = index;
    isSubmitLoading = true;
    update();
    printx("selectedIndex $selectedIndex");
    _prepareSaveDir();

    final headers = {
      'Authorization': "Bearer ${repo.apiClient.token}",
      'content-type': "application/pdf",
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      await saveAndOpenPDF(bytes, '${MyStrings.appName} ${DateTime.now()}.$extention');
    } else {
      try {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], isError: true, msg: []);
      } catch (e) {
        CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.somethingWentWrong], isError: true, msg: []);
      }
    }
    selectedIndex = -1;
    isSubmitLoading = false;
    update();
    print("selectedIndex $selectedIndex");
  }

  Future<void> saveAndOpenPDF(List<int> bytes, String fileName) async {
    final path = '$_localPath/$fileName';
    final file = File(path);
    await file.writeAsBytes(bytes);
    await openPDF(path);
  }

  Future<void> openPDF(String path) async {
    final file = File(path);
    if (await file.exists()) {
      CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.downloadSuccessfull], isError: false);
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.somethingWentWrong], isError: true, msg: []);
    }
  }
}
