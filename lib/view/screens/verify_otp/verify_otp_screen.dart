import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/screens/verify_otp/controller/verify_otp_controller.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<VerifyOtpController>(
            init: VerifyOtpController(Get.find(), Get.find()),
            builder: (final VerifyOtpController controller) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(AppResponsive.value(80, tablet: 24)),
                    SvgPicture.asset(Assets.svg.icVerifyLogo),
                    Gap(AppResponsive.value(16, tablet: 24)),
                    Text(
                      'Check your phone'.tr,
                      style: interW700.copyWith(
                        fontSize: 25,
                        color: AppColors.themeColor,
                      ),
                    ),
                    Gap(AppResponsive.value(5, tablet: 8)),
                    Text(
                      'Enter the 6 digit OTP sent to your mobile ${controller.mobile}'
                          .tr,
                      textAlign: TextAlign.center,
                      style: interW400.copyWith(
                        fontSize: 16,
                        color: AppColors.color414844,
                      ),
                    ),
                    Gap(AppResponsive.value(40, tablet: 60)),
                    OtpPinField(
                      key: controller.otpEmailPinFieldController,
                      onSubmit: (final String text) {
                        controller.setOTP(text);
                      },
                      onChange: (final String text) {
                        controller.setOTP(text);
                      },
                      otpPinFieldStyle: OtpPinFieldStyle(
                        defaultFieldBorderColor: AppColors.colorC1C8C2,
                        fieldBorderRadius: 8,
                        activeFieldBorderColor: AppColors.themeColor,
                        textStyle: interW500.copyWith(
                          fontSize: 24,
                          color: AppColors.themeColor,
                        ),
                      ),
                      otpPinFieldDecoration:
                          OtpPinFieldDecoration.defaultPinBoxDecoration,
                      maxLength: 6,
                      fieldWidth: 50,
                      fieldHeight: 50,
                      autoFocus: false,
                      autoFillEnable: true,
                      cursorColor: AppColors.themeColor,
                      cursorWidth: 2.0,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Gap(AppResponsive.value(30, tablet: 40)),
                    Text(
                      controller.start == 0 ? '' : controller.timerText,
                      style: interW400.copyWith(
                        fontSize: 16,
                        color: AppColors.color414844,
                      ),
                    ),
                    Gap(AppResponsive.value(24, tablet: 34)),
                    CommonButton(
                      icon: Assets.svg.icVerify,
                      btnText: 'Verify'.tr,
                      onPressed: () {
                        controller.checkValidation();
                      },
                    ),
                    Gap(AppResponsive.value(20, tablet: 25)),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive Otp? ",
                          style: interW400.copyWith(
                            color: AppColors.color414844,
                            fontSize: 16,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Resend it',
                              style: interW600.copyWith(
                                color: AppColors.color717973,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.clearOtpField();
                                  controller.resendOtpApiCall();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              );
            },
          ),
        ),
      ),
    );
  }
}
