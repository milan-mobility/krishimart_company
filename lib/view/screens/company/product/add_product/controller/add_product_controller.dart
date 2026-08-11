import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/utils/utility.dart';

class AddProductController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtProductName = TextEditingController();
  final TextEditingController txtCompany = TextEditingController();
  final TextEditingController txtCategory = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDose = TextEditingController();
  final TextEditingController txtCrops = TextEditingController();
  final TextEditingController txtYoutubeLink = TextEditingController();

  List<String> photoPaths = <String>[];

  Future<void> selectPhotos() async {
    photoPaths = await Utility.getPhotos();
    update();
  }

  void saveProduct() {
    if (formKey.currentState?.validate() ?? false) {
      Get.snackbar(
        'Product saved'.tr,
        'Your product has been saved successfully'.tr,
      );
    }
  }

  @override
  void onClose() {
    txtProductName.dispose();
    txtCompany.dispose();
    txtCategory.dispose();
    txtDescription.dispose();
    txtDose.dispose();
    txtCrops.dispose();
    txtYoutubeLink.dispose();
    super.onClose();
  }
}
