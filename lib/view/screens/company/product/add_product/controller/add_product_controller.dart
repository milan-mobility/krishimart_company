import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:video_player/video_player.dart';

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
  String? reelPath;
  VideoPlayerController? reelPreviewController;
  bool isSelectingReel = false;
  bool isCompressingReel = false;

  bool get isProcessingReel => isSelectingReel || isCompressingReel;

  Future<void> selectPhotos() async {
    photoPaths = await Utility.getPhotos();
    update();
  }

  Future<void> selectReel() async {
    isSelectingReel = true;
    update();

    final String? selectedVideoPath = await Utility.selectVideo();
    isSelectingReel = false;
    if (selectedVideoPath == null) {
      update();
      return;
    }

    isCompressingReel = true;
    update();
    final String? compressedVideoPath = await Utility.compressVideo(
      selectedVideoPath,
    );
    isCompressingReel = false;
    if (compressedVideoPath == null) {
      update();
      return;
    }

    await reelPreviewController?.dispose();
    final VideoPlayerController previewController = VideoPlayerController.file(
      File(compressedVideoPath),
    );
    reelPreviewController = previewController;

    try {
      await previewController.initialize();
      reelPath = compressedVideoPath;
    } catch (_) {
      await previewController.dispose();
      reelPreviewController = null;
      reelPath = null;
    }
    update();
  }

  void toggleReelPlayback() {
    final VideoPlayerController? previewController = reelPreviewController;
    if (previewController == null) return;

    if (previewController.value.isPlaying) {
      previewController.pause();
    } else {
      previewController.play();
    }
    update();
  }

  Future<void> removeReel() async {
    await reelPreviewController?.dispose();
    reelPreviewController = null;
    reelPath = null;
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
    reelPreviewController?.dispose();
    super.onClose();
  }
}
