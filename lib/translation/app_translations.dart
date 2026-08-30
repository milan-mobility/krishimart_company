import 'package:krishi_mart/translation/en_US/en_us_translations.dart';
import 'package:krishi_mart/translation/hindi/hi_translations.dart';

import 'gujarati/gu_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations =
      <String, Map<String, String>>{'en': enUs, 'gu': gu, 'hi': hi};
}
