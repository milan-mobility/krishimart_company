import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/view/screens/common_webview/common_webview.dart';
import 'package:krishi_mart/view/screens/company/complete_profile/complete_company_profile_screen.dart';
import 'package:krishi_mart/view/screens/company/edit_company_profile/edit_company_profile_screen.dart';
import 'package:krishi_mart/view/screens/company/home/company_home_screen.dart';
import 'package:krishi_mart/view/screens/company/product/add_product/add_product_screen.dart';
import 'package:krishi_mart/view/screens/company/product/list/product_screen.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/complete_dealer_profile_screen.dart';
import 'package:krishi_mart/view/screens/dealer/edit_dealer/edit_dealer_profile_screen.dart';
import 'package:krishi_mart/view/screens/dealer/home/dealer_home_screen.dart';
import 'package:krishi_mart/view/screens/dealer/product/add_product/add_dealer_product_screen.dart';
import 'package:krishi_mart/view/screens/dealer/product/edit_product/edit_dealer_product_screen.dart';
import 'package:krishi_mart/view/screens/login/login_screen.dart';
import 'package:krishi_mart/view/screens/notification/binding/notification_binding.dart';
import 'package:krishi_mart/view/screens/notification/notification_screen.dart';
import 'package:krishi_mart/view/screens/profile/profile_screen.dart';
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
  static const String editCompanyProfile = '/editCompanyProfile';
  static const String editDealerProfile = '/editDealerProfile';
  static const String addProduct = '/addProduct';
  static const String productList = '/product-list';
  static const String completeDealerProfile = '/completeDealerProfile';
  static const String dealerHome = '/dealer-home';
  static const String companyHomeScreen = '/companyHomeScreen';
  static const String addDealerProduct = '/addDealerProduct';
  static const String editDealerProduct = '/editDealerProduct';
  static const String commonWebView = '/commonWebView';
  static const String notificationScreen = '/notificationScreen';

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
    ),
    GetPage<dynamic>(
      name: addProduct,
      page: () => getRoute(const AddProductScreen()),
    ),
    GetPage<dynamic>(
      name: productList,
      page: () => getRoute(const ProductListScreen()),
    ),

    GetPage<dynamic>(
      name: completeDealerProfile,
      page: () => getRoute(const CompleteDealerProfileScreen()),
    ),
    GetPage<dynamic>(
      name: dealerHome,
      page: () => getRoute(const DealerHomeScreen()),
    ),
    GetPage<dynamic>(name: videos, page: () => getRoute(VideosScreen())),
    GetPage<dynamic>(
      name: profile,
      page: () => getRoute(const ProfileScreen()),
    ),
    GetPage<dynamic>(
      name: addDealerProduct,
      page: () => getRoute(const AddDealerProductScreen()),
    ),
    GetPage<dynamic>(
      name: editDealerProduct,
      page: () =>
          getRoute(EditDealerProductScreen(product: Get.arguments as dynamic)),
    ),
    GetPage<dynamic>(
      name: companyHomeScreen,
      page: () => getRoute(CompanyHomeScreen()),
    ),
    GetPage<dynamic>(
      name: commonWebView,
      page: () => getRoute(CommonWebview()),
    ),
    GetPage<dynamic>(
      name: notificationScreen,
      page: () => getRoute(NotificationScreen()),
      binding: NotificationBinding(),
    ),
    GetPage<dynamic>(
      name: editCompanyProfile,
      page: () => getRoute(EditCompanyProfileScreen()),
    ),
    GetPage<dynamic>(
      name: editDealerProfile,
      page: () => getRoute(EditDealerProfileScreen()),
    ),
  ];

  static Widget getRoute(final Widget navigateTo) {
    return navigateTo;
  }
}
