class UrlContainer {
  static const String baseUrl = 'https://script.viserlab.com/playlab/demo/';
  // static const String baseUrl = 'https://url8.viserlab.com/playlab/';
  // static const String baseUrl = 'http://192.168.30.113/playlab/3.1/';

  static const String registrationEndPoint = 'api/register';
  static const String loginEndPoint = 'api/login';
  static const String socialLoginEndPoint = 'api/social-login';
  static const String userLogoutEndPoint = 'api/user/logout';
  static const String userDeleteEndPoint = 'api/delete-account';
  static const String forgetPasswordEndPoint = 'api/password/email';
  static const String passwordVerifyEndPoint = 'api/password/verify-code';
  static const String resetPasswordEndPoint = 'api/password/reset';
  static const String pusherAuthenticate = 'api/authenticationApp';
  static const String watchPartyHistoryEndPoint = 'api/party/history';
  static const String createPartyEndPoint = 'api/party/create';
  static const String partyRoomDetailsEndPoint = 'api/party/room';
  static const String joinPartyEndPoint = 'api/party/join/request';
  static const String acceptPartyJoinRequestEndPoint = 'api/party/request/accept';
  static const String rejectPartyJoinRequestEndPoint = 'api/party/request/reject';
  static const String removeUserFromPartyEndPoint = 'api/party/status';
  static const String closePartyEndPoint = 'api/party/cancel/';
  static const String leavePartyEndPoint = 'api/party/leave/';
  static const String partyPlayerSettingsEndPoint = 'api/party/player/setting';
  static const String sendMsgEndPoint = 'api/party/send/message';
  static const String popUpAdsEndPoint = 'api/pop-up/ads';
  static const String languageUrl = 'api/language/';
  static const String onboardingEndPoint = 'api/welcome-info';
  static const String allEpisodeEndPoint = 'api/episodes?page=';
  static const String liveTvDetailsEndPoint = 'api/live-tv/';
  static const String playVideoEndPoint = 'api/play-video?item_id';
  static const String playVideoPaidEndPoint = 'api/play?item_id';
  static const String addInWishlistEndPoint = 'api/add-wishlist';
  static const String wishlistEndPoint = 'api/wishlists';
  static const String checkWishlistEndpoint = 'api/check-wishlist?';
  static const String removeFromWishlistEndPoint = 'api/remove-wishlist?';
  static const String watchHistoryEndPoint = 'api/history';
  static const String featuredMovieEndPoint = 'api/section/featured';
  static const String recentMovieEndPoint = 'api/section/recent';
  static const String latestSeriesEndPoint = 'api/section/latest';
  static const String singleBannerEndPoint = 'api/section/single';
  static const String trailerMovieEndPoint = 'api/section/trailer';
  static const String freeZoneEndPoint = 'api/section/free-zone';
  static const String movieSliderEndPoint = 'api/sliders';
  static const String dashboardEndPoint = 'api/dashboard';
  static const String userSubcriptionEndPoint = 'api/user/subscription';
  static const String sortsEndPoint = 'api/short/videos';
  static const String authSortsEndPoint = 'api/user/short/videos';
  static const String likeEndPoint = 'api/like';
  static const String favoriteList = 'api/reels/list';
  static const String liveTournamentsListEndPoint = 'api/live/tournaments';
  static const String liveTournamentDetailsEndPoint = 'api/user/tournament';
  static const String gameWatchEndPoint = 'api/user/watch/game';
  static const String liveTelevisionEndPoint = 'api/live-television/show_all'; //
  static const String searchEndPoint = 'api/search?page';
  static const String categoryEndPoint = 'api/categories';
  static const String subCategoryEndPoint = 'api/subcategories?category_id';

  static const String getPlanEndPoint = 'api/plans';
  static const String checkPlanStatusEndPoint = 'api/subscribe';
  static const String buyPlanEndPoint = 'api/subscribe-plan';
  static const String purchasePlanEndPoint = 'api/purchase-app';

  static const String watchVideoEndPoint = 'api/watch-video?item_id';
  static const String watchVideoPaidEndPoint = 'api/watch?item_id';
  static const String rentHistoryEndPoint = 'api/rented/items';

  static const String verifyEmailEndPoint = 'api/verify-email';
  static const String verifySmsEndPoint = 'api/verify-mobile';
  static const String resendVerifyCodeEndPoint = 'api/resend-verify';

  static const String authorizationCodeEndPoint = 'api/authorization';
  static const String depositHistoryEndPoint = 'api/deposit/history?page=';
  static const String depositMethodEndPoint = 'api/deposit/methods';
  static const String depositInsertEndPoint = 'api/deposit/insert';

  static const String manualPaymentEndpoint = 'api/purchase-plan';

  static const String generalSettingEndPoint = 'api/general-setting';
  static const String privacyPolicyEndPoint = 'api/policy-pages';
  static const String getProfileEndPoint = 'api/user-info';
  static const String updateProfileEndPoint = 'api/profile-setting';
  static const String changePasswordEndPoint = 'api/change-password';

  static const String deviceTokenEndPoint = 'api/add-device-token';
  static const String profileCompleteEndPoint = 'api/user-data-submit';

  static const String countryEndPoint = 'api/get-countries';

  static const String supportMethodsEndPoint = 'api/support/method';
  static const String supportListEndPoint = 'api/ticket';
  static const String storeSupportEndPoint = 'api/ticket/create';
  static const String supportViewEndPoint = 'api/ticket/view';
  static const String supportReplyEndPoint = 'api/ticket/reply';
  static const String supportCloseEndPoint = 'api/ticket/close';
  static const String supportDownloadEndPoint = 'api/ticket/download';
  static const String faqEndPoint = 'api/faq';

  //Url image
  static const String countryFlagImageLink = 'https://flagpedia.net/data/flags/h24/{countryCode}.webp';
  static const String withdraw = 'assets/images/verify/withdraw';
  static const String supportImagePath = '${baseUrl}assets/support/';
  static const String gameImagePath = '${baseUrl}assets/images/game';
}
