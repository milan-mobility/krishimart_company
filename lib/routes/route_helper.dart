import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/binding/complete_company_profile_binding.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/complete_company_profile_screen.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/add_product_screen.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/binding/product_binding.dart';
import 'package:krishi_mart/view/screens/company/product/list/binding/product_list_binding.dart';
import 'package:krishi_mart/view/screens/company/product/list/product_screen.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/binding/complete_dealer_profile_binding.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/complete_dealer_profile_screen.dart';
import 'package:krishi_mart/view/screens/dealer/home/binding/dealer_home_binding.dart';
import 'package:krishi_mart/view/screens/dealer/home/dealer_home_screen.dart';
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
  static const String completeCompanyProfile = '/completeCompanyProfile';
  static const String product = '/product';
  static const String productList = '/product-list';
  static const String completeDealerProfile = '/completeDealerProfile';
  static const String dealerHome = '/dealer-home';

  static const String home = '/home';
  static const String reels = '/reels';
  static const String videos = '/videos';
  static const String profile = '/profile';

  static List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(name: splash, page: () => getRoute(SplashScreen())),
    GetPage<dynamic>(name: login, page: () => getRoute(LoginScreen())),
    GetPage<dynamic>(
      name: userRole,
      page: () => getRoute(const UserRoleScreen()),
    ),
    GetPage<dynamic>(name: verifyOtp, page: () => getRoute(VerifyOtpScreen())),
    GetPage<dynamic>(
      name: completeCompanyProfile,
      page: () => getRoute(const CompleteCompanyProfileScreen()),
      binding: CompleteCompanyProfileBinding(),
    ),
    GetPage<dynamic>(
      name: product,
      page: () => getRoute(const AddProductScreen()),
      binding: ProductBinding(),
    ),
    GetPage<dynamic>(
      name: productList,
      page: () => getRoute(const ProductListScreen()),
      binding: ProductListBinding(),
    ),

    GetPage<dynamic>(
      name: completeDealerProfile,
      page: () => getRoute(const CompleteDealerProfileScreen()),
      binding: CompleteDealerProfileBinding(),
    ),
    GetPage<dynamic>(
      name: dealerHome,
      page: () => getRoute(const DealerHomeScreen()),
      binding: DealerHomeBinding(),
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
