import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/data/model/authorization/authorization_response_model.dart';
import 'package:play_lab/data/services/api_service.dart';
import 'package:play_lab/view/components/circle_icon_button.dart';
import 'package:http/http.dart' as http;
import 'package:play_lab/view/components/show_custom_snackbar.dart';

class PreviewImage extends StatefulWidget {
  String url;
  PreviewImage({super.key, required this.url});

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  void initState() {
    widget.url = Get.arguments;
    super.initState();
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
    checkPermission();
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

  Future<void> downloadAttachment(String url, String extention) async {
    isSubmitLoading = true;
    setState(() {});

    _prepareSaveDir();

    final headers = {
      'Authorization': "Bearer ${Get.find<ApiClient>().token}",
      'content-type': "application/pdf",
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      await saveFile(bytes, '${MyStrings.appName} ${DateTime.now()}.$extention');
    } else {
      try {
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
        CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], isError: true, msg: []);
      } catch (e) {
        CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.somethingWentWrong], isError: true, msg: []);
      }
    }

    isSubmitLoading = false;
    setState(() {});
  }

  Future<void> saveFile(List<int> bytes, String fileName) async {
    final path = '$_localPath/$fileName';
    final file = File(path);
    await file.writeAsBytes(bytes).then((v) {
      CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.downloadSuccessfull], isError: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: MyColor.transparentColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          CircleIconButton(
            onTap: () {
              String extention = widget.url.split('.').last;
              if (isSubmitLoading == false) {
                downloadAttachment(widget.url, extention);
              }
            },
            backgroundColor: MyColor.primaryColor,
            child: const Icon(Icons.download, color: MyColor.colorWhite),
          ),
          const SizedBox(width: Dimensions.space10)
        ],
      ),
      body: InteractiveViewer(
        child: Stack(
          children: [
            Opacity(
              opacity: isSubmitLoading ? 0.3 : 1,
              child: CachedNetworkImage(
                imageUrl: widget.url.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    boxShadow: const [],
                    // borderRadius:  BorderRadius.circular(radius),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                    child: Center(
                      child: SpinKitFadingCube(
                        color: MyColor.primaryColor.withOpacity(0.3),
                        size: Dimensions.space20,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: MyColor.colorGrey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isSubmitLoading) ...[
              const SpinKitFadingCircle(
                color: MyColor.primaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}
