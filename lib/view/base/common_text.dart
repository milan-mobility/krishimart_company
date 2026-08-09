import 'package:flutter/material.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CommonText extends StatelessWidget {
  const CommonText({
    super.key,
    required this.text,
    this.textColor = AppColors.color404943,
    this.fontSize = 16,
  });

  final String text;
  final double? fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: interW500.copyWith(
        fontSize: fontSize,
        color: AppColors.color404943,
      ),
    );
  }
}
