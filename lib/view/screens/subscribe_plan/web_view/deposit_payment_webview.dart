import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_lab/view/screens/subscribe_plan/web_view/webview_widget.dart';

import '../../../../core/utils/my_color.dart';
import '../../../components/app_bar/custom_appbar.dart';


class CustomWebViewScreen extends StatefulWidget {
  const CustomWebViewScreen({super.key,required this.redirectUrl});
  final String redirectUrl;

  @override
  State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();
}

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  @override
  void initState() {
    super.initState();
    permissionServices();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      appBar: const CustomAppBar(title: '',isShowBackBtn: true,),
      body: MyWebViewWidget(url: widget.redirectUrl),
      floatingActionButton: favoriteButton(),
    );
  }


  Widget favoriteButton() {
    return FloatingActionButton(
      backgroundColor: MyColor.redCancelTextColor,
      onPressed: () async {
        Get.back();
      },
      child: const Icon(Icons.cancel,color: MyColor.colorWhite,size: 30,),
    );
  }


  Future<Map<Permission, PermissionStatus>> permissionServices() async{

    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.microphone,
      Permission.mediaLibrary,
      Permission.camera,
      Permission.storage,
    ].request();

    return statuses;
  }

}

