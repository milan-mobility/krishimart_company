import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/helpers/app_colors.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/helpers/styles.dart';
import 'package:krishi_mart/view/base/common_button.dart';
import 'package:krishi_mart/view/base/common_text_field.dart';
import 'package:krishi_mart/view/screens/login/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        init: LoginController(Get.find(), Get.find()),
        builder: (final LoginController controller) {
          return SafeArea(
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(Assets.png.icLoginLogo.path),
                        ),
                        Text(
                          'Welcome to AgriHub'.tr,
                          style: interW700.copyWith(
                            fontSize: 25,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Gap(AppResponsive.value(5, tablet: 8)),
                        Text(
                          'Login using Mobile Number'.tr,
                          style: interW400.copyWith(
                            fontSize: 16,
                            color: AppColors.color414844,
                          ),
                        ),
                      ],
                    ),
                    Gap(AppResponsive.value(30, tablet: 45)),
                    Text(
                      'Mobile Number'.tr,
                      style: interW600.copyWith(color: AppColors.color191C1C),
                    ),
                    Gap(AppResponsive.value(10, tablet: 15)),
                    CommonTextField(
                      controller: controller.txtPhone,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      maxLength: 10,
                      hintText: 'Mobile number'.tr,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.colorEFECFF,
                          width: AppResponsive.space(0),
                        ),
                      ),
                      prefixIcon: SvgPicture.asset(Assets.svg.icMobile),
                      validator: (final String? value) {
                        final phone = value?.trim() ?? '';

                        if (phone.isEmpty) {
                          return 'Please enter phone number'.tr;
                        }

                        if (phone.length != 10) {
                          return 'Please enter 10 digit mobile number'.tr;
                        }

                        return null;
                      },
                    ),
                    Gap(AppResponsive.value(24, tablet: 34)),
                    CommonButton(
                      icon: Assets.svg.icNext,
                      btnText: 'Send OTP',
                      onPressed: () {
                        controller.checkValidation();
                      },
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
