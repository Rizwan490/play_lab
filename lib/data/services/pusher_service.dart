import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;

class PusherService extends ChangeNotifier {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final String _apiKey = "15d782b9814d59f4b88b";
  String channelName = "private-market-data";
  final String _cluster = 'ap2';
  void initPusher() async {
    try {
      await pusher.init(
        apiKey: _apiKey,
        cluster: _cluster,
        onConnectionStateChange: (String a, String b) async {
          print("a $a");
          print("b $b");
          notifyListeners();
        },
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: (_, a) {},
        onMemberAdded: (_, a) {},
        onMemberRemoved: (_, a) {},
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  Future<void> subscribeToChannel(String channelName, {String? eventType, required bool istrigger}) async {
    // print('inside subcribe');
    if (!istrigger) {
      await pusher.subscribe(
        channelName: channelName,
      );
    }
    // print('subscribed..... ');
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    print("Me: $me");
    // print('subscribed success');
  }

  void onEvent(PusherEvent event) {
    print("Evennt found" + event.data);
    final eventData = json.decode(event.data) as Map<String, dynamic>;
    addMessage(eventData);
  }

  final List<Map<String, dynamic>> _messageEventList = [];
  List<Map<String, dynamic>> get messageList => _messageEventList;
  Future<void> addMessage(Map<String, dynamic> data) async {
    print(data);
    _messageEventList.add(data);
    try {
      notifyListeners();
      // print('notifier done');
      // await pusher.trigger(PusherEvent(channelName: "my-channel", eventName: "my-event", data: _messageEventList));
    } catch (e) {
      // print('thrown error ${e.toString()}');
    }
    print("$_messageEventList");
  }

  onAuthorizer(String channelName, String socketId, options) async {
    socketId = socketId;
    notifyListeners();
    var authUrl = "https://script.viserlab.com/vinance/pusher/auth/$socketId/private-market-data";
    var result = await http.post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var json = jsonDecode(result.body);
    return json;
  }
}
