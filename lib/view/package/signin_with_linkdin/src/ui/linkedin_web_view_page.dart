import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../signin_with_linkedin.dart';
import '../core/authorize_user.dart';

typedef OnGetAuthToken = void Function(LinkedInAccessToken data);
typedef OnGetUserProfile = void Function(
  LinkedInAccessToken tokenData,
  LinkedInUser user,
);
typedef OnSignInError = void Function(LinkedInError error);

/// Web view page that handles url navigation and get the auth code when user
/// sign in successfully and then call access token and user profile API.
class LinkedInWebViewPage extends StatefulWidget {
  final OnGetUserProfile? onGetUserProfile;
  final PreferredSizeWidget? appBar;

  const LinkedInWebViewPage({
    super.key,
    required this.onGetUserProfile,
    this.appBar,
  });

  @override
  State<LinkedInWebViewPage> createState() => _LinkedInWebViewPageState();
}

class _LinkedInWebViewPageState extends State<LinkedInWebViewPage> {
  late WebViewController _webViewController;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            _loading = false;
          },
          onNavigationRequest: (request) async {
            final isRedirect = request.url.startsWith(LinkedInApi.instance.config.redirectUrl);
            if (isRedirect) {
              _manageBack(request);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(LinkedInApi.instance.config.authorizationUrl));
  }

  Future<void> _manageBack(NavigationRequest request) async {
    final data = await authorizeUser(
      request.url,
      onGetUserProfile: widget.onGetUserProfile,
    );
    if (mounted && data != null) Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _loading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
          WebViewWidget(controller: _webViewController),
        ],
      ),
    );
  }
}
