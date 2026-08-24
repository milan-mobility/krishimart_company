import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/helpers/extensions/date_time_ext.dart';

String sanitizeUtf16String(
  final String value, {
  final String replacement = '',
}) {
  if (value.isEmpty) return value;

  final StringBuffer buffer = StringBuffer();
  final List<int> codeUnits = value.codeUnits;

  for (int index = 0; index < codeUnits.length; index++) {
    final int unit = codeUnits[index];
    final bool isHighSurrogate = unit >= 0xD800 && unit <= 0xDBFF;
    final bool isLowSurrogate = unit >= 0xDC00 && unit <= 0xDFFF;

    if (isHighSurrogate) {
      if (index + 1 < codeUnits.length) {
        final int nextUnit = codeUnits[index + 1];
        final bool nextIsLowSurrogate =
            nextUnit >= 0xDC00 && nextUnit <= 0xDFFF;
        if (nextIsLowSurrogate) {
          buffer.writeCharCode(unit);
          buffer.writeCharCode(nextUnit);
          index++;
          continue;
        }
      }

      buffer.write(replacement);
      continue;
    }

    if (isLowSurrogate) {
      buffer.write(replacement);
      continue;
    }

    buffer.writeCharCode(unit);
  }

  return buffer.toString();
}

extension StringExt on String? {
  bool isNotNullAndEmpty() {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  String sanitizeText({final String fallback = ''}) {
    if (this == null || this!.isEmpty) {
      return fallback;
    }

    return sanitizeUtf16String(this!);
  }

  String convertToDayDigit() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return DateFormat('yyyy-MM-dd').parse(this!).formatToDayOnly();
  }

  String convertToDay() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return DateFormat('yyyy-MM-dd').parse(this!, false).formatToDay();
  }

  String getBillDate() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return DateFormat('yyyy-MM-dd').parse(this!, false).formatDDMMYYYY();
  }

  String formatDDMMMYYYY() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return DateFormat('yyyy-MM-dd').parse(this!, false).formatDDMMMYYYY();
  }

  String convertUtcToLocalDDMMYYYY() {
    if (this == null || this!.isEmpty) return '';

    final DateTime localDate = DateTime.parse(this!).toLocal();

    return DateFormat('dd/MM/yyyy').format(localDate);
  }

  String getMonth() {
    if (this == null || this!.isEmpty) {
      return '';
    }
    return DateFormat('yyyy-MM').parse(this!).formatMMM();
  }

  DateTime getCurrentDate() {
    if (this == null || this!.isEmpty) {
      return DateTime.now();
    }
    return DateTime.parse(this!);
  }

  String getInitials() {
    final String value = sanitizeText().trim();
    if (value.isEmpty) return '';

    // Split by spaces and remove any empty items
    final List<String> words = value.split(RegExp(r'\s+'));

    if (words.length == 1) {
      // Only one word → take first letter
      return words[0][0].toUpperCase();
    } else {
      // More than one word → take first two words only
      return (words[0][0] + words[1][0]).toUpperCase();
    }
  }

  Color generateColorFromInitials() {
    // Simple hash based on initials
    final int hash = sanitizeText().runes.fold(
      0,
      (final int prev, final int element) => prev + element,
    );
    final List<Color> colors = <Color>[
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
      Colors.indigo,
      Colors.deepOrange,
    ];

    // Pick color deterministically
    return colors[hash % colors.length];
  }

  String imageUrl() {
    return '${Endpoints.imageUrl}/${this!}';
  }
}
