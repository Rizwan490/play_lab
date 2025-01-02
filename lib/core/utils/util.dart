import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_color.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class MyUtil {
  static String generateRandomAlphanumeric() {
    final random = Random();

    // ASCII values for 'a' to 'z', 'A' to 'Z', '0' to '9'
    const lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';

    // Concatenate all characters
    const allCharacters = lowerCaseLetters + upperCaseLetters + numbers;
    // Generate a random string of length 8
    final randomString = List.generate(8, (index) {
      final randomIndex = random.nextInt(allCharacters.length);
      return allCharacters[randomIndex];
    }).join('');

    return randomString;
  }

  static changeTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: MyColor.colorBlack, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.colorBlack, systemNavigationBarIconBrightness: Brightness.light));
  }

  static dynamic getShadow() {
    return [
      BoxShadow(
        blurRadius: 15.0,
        offset: const Offset(0, 25),
        color: Colors.grey.shade500.withOpacity(0.6),
        spreadRadius: -35.0,
      ),
    ];
  }

  static dynamic getShadow2({double blurRadius = 8}) {
    return [
      BoxShadow(
        color: MyColor.getShadowColor().withOpacity(0.3),
        blurRadius: blurRadius,
        spreadRadius: 3,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: MyColor.getShadowColor().withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: blurRadius,
        offset: const Offset(0, 1),
      ),
    ];
  }

  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  //
  static String getRoomIdRedirectUrl(String redirectUrl) {
    print("roomId ${redirectUrl.split('room/').last.split('/').first}");
    return redirectUrl.split('room/').last.split('/').first;
  }

  static String getGuestIdRedirectUrl(String redirectUrl) {
    print("roomId ${redirectUrl.split('room/').last.split('/').first}");
    return redirectUrl.split('room/').last.split('/').last;
  }

  static String getUserNameAndMassageFromHtml(String html) {
    // Parse the HTML string
    dom.Document document = parse(html);

    // Get the username
    String username = document.querySelector('.username')!.text.trim();

    // Get the message content
    String message = document.querySelector('.message')!.text.trim();

    // Output the results
    return "${username.replaceAll('@', '')}.$message";
  }

  static final urlCheckReg = RegExp(r"((http|https)://)(www.)?" "[a-zA-Z0-9@:%._\\+~#?&//=]" "{2,256}\\.[a-z]" "{2,6}\\b([-a-zA-Z0-9@:%" "._\\+~#?&//=]*)");

  static final checkImageUrlReg = RegExp(r"(https?:\/\/.*\.(?:jpg|jpeg|png|webp|avif|gif|svg))");

  static bool isImageUrl(String url) {
    return checkImageUrlReg.hasMatch(url);
  }

  static bool isValid(String url) {
    return urlCheckReg.hasMatch(url);
  }
}
