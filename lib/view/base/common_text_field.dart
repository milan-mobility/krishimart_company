import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.style,
    this.prefixIconConstraints,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.textInputAction,
    required this.controller,
    this.validator,
    this.readOnly,
    this.onTap,
    this.onChange,
    this.inputFormatter,
    this.keyboardType = TextInputType.text,
    this.maxLines,
    this.minLines,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign,
    this.enabled = true,
    this.disabledColor,
    this.onSubmitted,
    this.headerTitle,
    this.isObsecure = false,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.onChangedToggle,
    this.suffixIconWidgetHeight,
    this.suffixIconWidgetWidth,
    this.suffixIconWidget,
    this.isPassword = false,
    this.focusNode,
    this.hintText,
    this.hintStyle,
    this.maxLength,
    this.prefixIconPadding,
    this.fillColor,
    this.cursorHeight,
  });

  final double? cursorHeight;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final String? hintText;
  final Widget? suffixIconWidget;
  final double? suffixIconWidgetWidth;
  final double? suffixIconWidgetHeight;
  final bool isObsecure;
  final bool isPasswordVisible;
  final bool enabled;
  final Color? disabledColor;
  final TextStyle? style;
  final BoxConstraints? prefixIconConstraints;
  final InputBorder? border;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final TextCapitalization textCapitalization;
  final TextAlign? textAlign;
  final String? headerTitle;
  final bool isPassword;
  final Function(bool)? onVisibilityToggle;
  final Function(bool)? onChangedToggle;
  final FocusNode? focusNode;
  final int? maxLength;
  final EdgeInsetsGeometry? prefixIconPadding;

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      enabled: enabled,
      obscureText: isObsecure,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: inputFormatter,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onTapOutside: (final PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      focusNode: focusNode,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      onFieldSubmitted:
          onSubmitted ??
          (final String value) => FocusScope.of(context).nextFocus(),
      onChanged: onChange,
      controller: controller,
      cursorHeight: cursorHeight,
      cursorColor: Colors.black,
      cursorWidth: AppResponsive.space(1),
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      textInputAction: textInputAction ?? TextInputAction.next,
      style:
          style ??
          interW400.copyWith(
            fontSize: AppResponsive.font(15),
            color: AppColors.black,
          ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        counter: SizedBox(),
        filled: true,
        fillColor: fillColor ?? AppColors.colorECEEED,
        contentPadding: EdgeInsetsDirectional.only(
          start: AppResponsive.space(20),
          top: AppResponsive.space(12),
          bottom: AppResponsive.space(12),
        ),
        label: null,
        hintText: hintText ?? '',
        hintStyle:
            hintStyle ??
            interW400.copyWith(
              fontSize: AppResponsive.font(14),
              color: AppColors.colorBFC9C1,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIconConstraints:
            prefixIconConstraints ??
            BoxConstraints(
              maxHeight: AppResponsive.space(30),
              maxWidth: AppResponsive.space(70),
            ),
        suffixIconConstraints:
            prefixIconConstraints ??
            BoxConstraints(
              maxHeight: AppResponsive.space(40),
              maxWidth: AppResponsive.space(70),
            ),
        border:
            border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorBFC9C1,
                width: AppResponsive.space(1),
              ),
            ),
        focusedBorder:
            border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorBFC9C1,
                width: AppResponsive.space(1),
              ),
            ),
        enabledBorder:
            border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorBFC9C1,
                width: AppResponsive.space(1),
              ),
            ),
        errorBorder:
            border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.themeColor,
                width: AppResponsive.space(1),
              ),
            ),
        disabledBorder:
            border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorBFC9C1,
                width: AppResponsive.space(1),
              ),
            ),
        focusedErrorBorder:
            border ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorBFC9C1,
                width: AppResponsive.space(1),
              ),
            ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(
                  end: AppResponsive.space(15),
                  start: AppResponsive.space(15),
                ),
                child: prefixIcon,
              )
            : null,

        suffixIcon: isPassword
            ? Padding(
                padding:
                    prefixIconPadding ??
                    EdgeInsetsDirectional.only(
                      start: AppResponsive.space(15),
                      end: AppResponsive.space(14),
                    ),
                child: InkWell(
                  onTap: () => onVisibilityToggle!(!isPasswordVisible),
                  child: isPasswordVisible
                      ? Icon(
                          Icons.visibility,
                          size: AppResponsive.space(24),
                          color: AppColors.themeColor,
                        )
                      : Icon(
                          Icons.visibility_off,
                          size: AppResponsive.space(24),
                          color: AppColors.themeColor,
                        ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  onChangedToggle?.call(true);
                },
                child: SizedBox(
                  width: suffixIconWidgetWidth,
                  height: suffixIconWidgetHeight,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: AppResponsive.space(14),
                    ),
                    child: suffixIcon,
                  ),
                ),
              ),
        isDense: true,
      ),
    );
  }
}
