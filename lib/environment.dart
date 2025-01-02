import 'package:play_lab/data/model/reels/reels_response_list.dart';

class Environment {
/* ATTENTION Please update your desired data. */

  static const String appName = 'PlayLab';
  static const String version = '2.5';

  //LANGUAGE
  static String defaultLangCode = "en";
  static String defaultLanguageName = "English";

  // LOGIN AND REG PART
  static String defaultPhoneCode = "1"; //don't put + here
  static String defaultCountryCode = "USA";
  static int otpTime = 60; //second
  static List<Reel> sorts = [
    Reel(
      video: "https://videos.pexels.com/video-files/27961886/12274254_1440_2560_50fps.mp4",
      likes: "0",
      unlikes: "0",
      id: "0",
    ),
    Reel(
      video: "https://videos.pexels.com/video-files/4763826/4763826-uhd_2732_1440_24fps.mp4",
      likes: "0",
      unlikes: "0",
      id: "1",
    ),
    Reel(
      video: "https://videos.pexels.com/video-files/3692633/3692633-hd_1920_1080_30fps.mp4",
      likes: "0",
      unlikes: "0",
      id: "2",
    ),
    Reel(
      video: "https://videos.pexels.com/video-files/856813/856813-hd_1920_1080_30fps.mp4",
      likes: "0",
      unlikes: "0",
      id: "3",
    ),
    Reel(
      video: "https://videos.pexels.com/video-files/3251808/3251808-uhd_2560_1440_25fps.mp4",
      likes: "0",
      unlikes: "0",
      id: "4",
    ),
  ];
}
