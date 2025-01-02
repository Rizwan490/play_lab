import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({super.key, required this.url});

  final String url;

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {
  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  String url = '';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  bool isKycPending = false;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return Stack(
      children: [
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox(),
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          initialOptions: options,
          onLoadStart: (controller, url) {
            // print('url: $url');
            if (url.toString() ==
                '${UrlContainer.baseUrl}user/payment/history') {
              Get.offAndToNamed(RouteHelper.paymentHistoryScreen);

              CustomSnackbar.showCustomSnackbar(
                  errorList: [],
                  msg: [MyStrings.requestSuccess.tr],
                  isError: false);
            } else if (url.toString() ==
                '${UrlContainer.baseUrl}user/payment') {
              Get.back();
              CustomSnackbar.showCustomSnackbar(
                  errorList: [MyStrings.requestFailed.tr],
                  msg: [],
                  isError: true);
            }

            setState(() {
              this.url = url.toString();
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                );
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            setState(() {
              isLoading = false;
              this.url = url.toString();
            });
          },
          onLoadError: (controller, url, code, message) {},
          onProgressChanged: (controller, progress) {},
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
            });
          },
          onConsoleMessage: (controller, consoleMessage) {},
        )
      ],
    );
  }
}
