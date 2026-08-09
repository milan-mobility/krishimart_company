import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String formatHour() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('hh').format(this!).toString();
    }
  }

  String formatMinute() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('mm').format(this!).toString();
    }
  }

  String formatA() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('a').format(this!).toString();
    }
  }

  String formatToDayOnly() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('MMM, dd yyyy').format(_getLocalDate());
    }
  }

  String formatToDay() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('EEE').format(_getLocalDate());
    }
  }

  String formatDDMMYYYYEEEE() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd/MM/yyyy (EEEE)').format(_getLocalDate());
    }
  }

  String formatDDMMMYYYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd MMM, yyyy').format(_getLocalDate());
    }
  }

  String formatDDMMYYYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('dd/MM/yyyy').format(_getLocalDate());
    }
  }

  String formatYYYYMMDD() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('yyyy-MM-dd').format(_getLocalDate());
    }
  }

  String formatYYYYMM() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('yyyy-MM').format(_getLocalDate());
    }
  }

  String formatYYYY() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('yyyy').format(_getLocalDate());
    }
  }

  String formatMMM() {
    if (this == null) {
      return '';
    } else {
      return DateFormat('MMM').format(_getLocalDate());
    }
  }

  DateTime _getLocalDate() {
    return this!;
  }

  String greeting() {
    final hour = this!.hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning".tr;
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon".tr;
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening".tr;
    } else {
      return "Good Night".tr;
    }
  }
}
