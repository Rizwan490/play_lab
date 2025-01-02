import 'package:get/get.dart';
import 'package:play_lab/view/screens/my_reels/my_reels_screen.dart';
import 'package:play_lab/view/screens/tournament/tournament_details_screen.dart';
import 'package:play_lab/view/screens/tournament/tournament_list_screen.dart';
import 'package:play_lab/view/screens/faq/faq_screen.dart';
import 'package:play_lab/view/screens/game/game_watch_screen.dart';
import 'package:play_lab/view/screens/language/language_screen.dart';
import 'package:play_lab/view/screens/movie_details/movie_details.dart';
import 'package:play_lab/view/screens/my_search/search_screen.dart';
import 'package:play_lab/view/screens/onboard/onboard_screen.dart';
import 'package:play_lab/view/screens/party/watch_party_history/watch_party_history_screen.dart';
import 'package:play_lab/view/screens/party/watch_party_room/watch_party_room_screen.dart';
import 'package:play_lab/view/screens/preview_image/preview_image.dart';
import 'package:play_lab/view/screens/rent/rent_item_list.dart';
import 'package:play_lab/view/screens/reels_video/reels_video_screen.dart';
import 'package:play_lab/view/screens/splash/splash_screen.dart';
import 'package:play_lab/view/screens/sub_category/sub_category_screen.dart';
import 'package:play_lab/view/screens/subscribe_plan/add_deposit_screen/add_deposit_screen.dart';
import 'package:play_lab/view/screens/subscribe_plan/subscribe_plan_screen.dart';
import 'package:play_lab/view/screens/subscribe_plan/web_view/deposit_payment_webview.dart';
import 'package:play_lab/view/screens/ticket/all_ticket_screen.dart';
import 'package:play_lab/view/screens/ticket/new_ticket_screen/new_ticket_screen.dart';
import 'package:play_lab/view/screens/ticket/ticket_details/ticket_details.dart';
import 'package:play_lab/view/screens/watch_history/my_watch_history.dart';
import 'package:play_lab/view/screens/wish_list/wish_list_screen.dart';
import '../../view/screens/about/privacy_screen.dart';
import '../../view/screens/account/chagne_password/change_password.dart';
import '../../view/screens/account/payment_log_screen/transaction_log_screen.dart';
import '../../view/screens/account/profile/profile_complete_screen.dart';
import '../../view/screens/account/profile/profile_screen.dart';
import '../../view/screens/all_episode/all_episode_screen.dart';
import '../../view/screens/all_free_zone/free_zone_screen.dart';
import '../../view/screens/all_live_tv/live_tv.dart';
import '../../view/screens/auth/email_verification_page/email_verification_screen.dart';
import '../../view/screens/auth/forget_password/forget_password.dart';
import '../../view/screens/auth/forget_password/reset_pass_screen/reset_pass_screen.dart';
import '../../view/screens/auth/forget_password/verify_forget_password_code_screen/verify_forget_pass_code.dart';
import '../../view/screens/auth/login/login.dart';
import '../../view/screens/auth/registration/registration_screen.dart';
import '../../view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import '../../view/screens/bottom_nav_pages/all_movies/all_movies_screen.dart';
import '../../view/screens/bottom_nav_pages/home/home_screen.dart';
import '../../view/screens/live_tv_details/live_tv_details_screen.dart';

class RouteHelper {
  static const String splashScreen = '/splash-screen';

  //auth
  static const String loginScreen = '/login-screen';
  static const String onboardScreen = '/onboard-screen';
  static const String registrationScreen = '/signup-screen';
  static const String emailVerificationScreen = '/verify-email-screen';
  static const String smsVerificationScreen = '/verify-sms-screen';
  static const String forgetPasswordScreen = '/forget-password-screen';
  static const String verifyPassCodeScreen = '/verify-pass-code-screen';
  static const String resetPasswordScreen = '/reset-pass-screen';

  //sub category
  static const String subCategoryScreen = '/sub-category-screen';

  //nav screen
  static const String allMovieScreen = '/all-movie-screen';
  static const String allEpisodeScreen = '/all-episode-screen';
  static const String homeScreen = '/home-screen';
  static const String wishListScreen = '/wishlist-screen';

  //live tv
  static const String allLiveTVScreen = '/all-live-tv-screen';
  static const String liveTvDetailsScreen = '/live-tv-details-screen';

  //
  static const String allFreeZoneScreen = '/all-free-zone-screen';

  //webview
  static const String customWebviewScreen = '/custom-wv-screen';

  //nav drawer
  static const String profileScreen = '/profile-screen';
  static const String profileComplete = '/profile-complete-screen';
  static const String changePasswordScreen = '/change-password-screen';
  static const String subscribeScreen = '/subscribe-screen';
  static const String depositScreen = '/deposit-screen';
  static const String myWatchHistoryScreen = '/history-screen';
  static const String paymentHistoryScreen = '/payment-screen';
  static const String privacyScreen = '/privacy-screen';

  //other
  static const String movieDetailsScreen = '/movie-details-screen';
  static const String searchScreen = '/movie-search-screen';
  // watch party
  static const String watchPartyRoomScreen = '/watch-party-screen';
  static const String watchPartyHistoryScreen = '/watch-party-history-screen';
  static const String joinPartyScreen = '/join-party-screen';
  static const String rentItemScreen = '/rent-item-screen';

  static const String supportTicketMethodsList = '/all_ticket_methods';
  static const String allTicketScreen = '/all_ticket_screen';
  static const String ticketDetailsdScreen = '/ticket_details_screen';
  static const String newTicketScreen = '/new_ticket_screen';

  static const String faqScreen = '/faq-screen';
  static const String languageScreen = '/language-screen';

  static const String previewImageScreen = "/preview-image-screen";

  static const String reelsVideoScreen = "/sort-video-screen";
  static const String myreelsVideoScreen = "/my-reels-list-screen";

  static const String tournamentListScreen = "/event-list-screen";
  static const String tournamentDetailsScreen = "/event-details-screen";
  static const String gameWatchScreen = "/game-watch-screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardScreen, page: () => const OnBoardingScreen()),
    GetPage(name: allMovieScreen, page: () => const AllMovieScreen()),
    GetPage(name: allEpisodeScreen, page: () => const AllEpisodeScreen()),

    //nav
    GetPage(name: customWebviewScreen, page: () => CustomWebViewScreen(redirectUrl: Get.arguments)),
    GetPage(name: privacyScreen, page: () => const PrivacyScreen()),
    GetPage(name: wishListScreen, page: () => const WishListScreen()),
    GetPage(name: myWatchHistoryScreen, page: () => const MyWatchHistoryScreen()),
    GetPage(name: subscribeScreen, page: () => const SubscribePlanScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: profileComplete, page: () => const ProfileCompleteScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: paymentHistoryScreen, page: () => const PaymentLogsScreen()),

    //auth
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: emailVerificationScreen, page: () => const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),

    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: movieDetailsScreen, page: () => MovieDetailsScreen(itemId: Get.arguments[0], episodeId: Get.arguments[1])),
    GetPage(name: searchScreen, page: () => SearchScreen(searchText: Get.arguments)),
    GetPage(name: allLiveTVScreen, page: () => const AllLiveTvScreen()),
    GetPage(name: liveTvDetailsScreen, page: () => const LiveTvDetailsScreen()),
    GetPage(name: subCategoryScreen, page: () => SubCategoryScreen(categoryId: Get.arguments[0], categoryName: Get.arguments[1])),
    GetPage(name: depositScreen, page: () => const AddDepositScreen()),
    GetPage(name: allFreeZoneScreen, page: () => const AllFreeZoneScreen()),
    GetPage(name: watchPartyRoomScreen, page: () => const WatchPartyRoom()),
    GetPage(name: watchPartyHistoryScreen, page: () => const WatchPartyHistoryScreen()),
    GetPage(name: rentItemScreen, page: () => const RentItemListScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),

    GetPage(name: allTicketScreen, page: () => const AllTicketScreen()),
    GetPage(name: ticketDetailsdScreen, page: () => const TicketDetailsScreen()),
    GetPage(name: newTicketScreen, page: () => const NewTicketScreen()),
    GetPage(name: previewImageScreen, page: () => PreviewImage(url: Get.arguments)),

    GetPage(name: reelsVideoScreen, page: () => const ReelsVideoScreen()),
    GetPage(name: myreelsVideoScreen, page: () => const MyReelsVideoScreen()),

    GetPage(name: tournamentListScreen, page: () => const TournamentListScreen()),
    GetPage(name: tournamentDetailsScreen, page: () => const TournamentDetailsScreen()),
    GetPage(name: gameWatchScreen, page: () => const GameWatchScreen()),

    GetPage(name: languageScreen, page: () => const LanguageScreen()),
  ];
}
