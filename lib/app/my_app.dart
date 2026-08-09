import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/translation/app_translations.dart';
import 'package:krishi_mart/utils/app_constants.dart';
import 'package:krishi_mart/view/base/global_loader_widget.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SharedPreferenceHelper sharedPref = Get.find<SharedPreferenceHelper>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: AppColors.white,
        brightness: Brightness.light,
      ),
      initialRoute: RouteHelper.splash,
      getPages: RouteHelper.routes,
      translationsKeys: AppTranslation.translations,
      defaultTransition: Transition.noTransition,
      locale: Locale(sharedPref.getLanguageCode),
      fallbackLocale: const Locale('en'),
      supportedLocales: const <Locale>[Locale('en'), Locale('gu')],
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return MediaQuery.withNoTextScaling(child: GlobalLoader(child: child!));
      },
    );
  }
}
