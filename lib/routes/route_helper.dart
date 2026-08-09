import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/complete_profile/complete_farmer_profile_screen.dart';
import 'package:krishi_mart/view/screens/home/home_screen.dart';
import 'package:krishi_mart/view/screens/login/login_screen.dart';
import 'package:krishi_mart/view/screens/profile/profile_screen.dart';
import 'package:krishi_mart/view/screens/reels/reels_screen.dart';
import 'package:krishi_mart/view/screens/splash/splash_screen.dart';
import 'package:krishi_mart/view/screens/user_role/user_role_screen.dart';
import 'package:krishi_mart/view/screens/verify_otp/verify_otp_screen.dart';
import 'package:krishi_mart/view/screens/videos/videos_screen.dart';

class RouteHelper {
  //Auth Module
  static const String splash = '/splash';
  static const String login = '/login';
  static const String userRole = '/userRole';
  static const String verifyOtp = '/verifyOtp';
  static const String completeFarmerProfile = '/completeFarmerProfile';

  static const String home = '/home';
  static const String reels = '/reels';
  static const String videos = '/videos';
  static const String profile = '/profile';

  static List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(name: splash, page: () => getRoute(SplashScreen())),
    GetPage<dynamic>(name: login, page: () => getRoute(LoginScreen())),
    GetPage<dynamic>(name: userRole, page: () => getRoute(UserRoleScreen())),
    GetPage<dynamic>(name: verifyOtp, page: () => getRoute(VerifyOtpScreen())),
    GetPage<dynamic>(
      name: completeFarmerProfile,
      page: () => getRoute(CompleteFarmerProfileScreen()),
    ),
    GetPage<dynamic>(name: home, page: () => getRoute(HomeScreen())),
    GetPage<dynamic>(name: reels, page: () => getRoute(ReelsScreen())),
    GetPage<dynamic>(name: videos, page: () => getRoute(VideosScreen())),
    GetPage<dynamic>(name: profile, page: () => getRoute(ProfileScreen())),
  ];

  static Widget getRoute(final Widget navigateTo) {
    return navigateTo;
  }
}
