import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/model/category_model.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/repository/product_repo.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';
import 'package:krishi_mart/view/screens/company/product/list/controller/product_controller.dart';
import 'package:video_player/video_player.dart';

class AddProductController extends GetxController {
  AddProductController(this.commonController, this.productRepo);

  final CommonController commonController;
  final ProductRepo productRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtProductName = TextEditingController();
  final TextEditingController txtCompany = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDose = TextEditingController();
  final TextEditingController txtYoutubeLink = TextEditingController();

  List<String> photoPaths = <String>[];
  String? reelPath;
  VideoPlayerController? reelPreviewController;
  bool isSelectingReel = false;
  bool isCompressingReel = false;
  Category? selectedCategory;
  IdName? selectedCrop;

  bool get isProcessingReel => isSelectingReel || isCompressingReel;

  @override
  void onInit() {
    super.onInit();
    _loadProductOptions();
  }

  Future<void> _loadProductOptions() async {
    await Future.wait<void>(<Future<void>>[
      commonController.getCategories(),
      commonController.getCrops(),
    ]);
    update();
  }

  void selectCategory(final Category? category) {
    selectedCategory = category;
    update();
  }

  void selectCrop(final IdName? crop) {
    selectedCrop = crop;
    update();
  }

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

  Future<void> saveProduct() async {
    if (!(formKey.currentState?.validate() ?? false) ||
        selectedCategory == null ||
        selectedCrop == null) {
      showErrorSnackBar(message: 'Please complete all required fields'.tr);
      return;
    }
    if (photoPaths.isEmpty) {
      showErrorSnackBar(message: 'Please add at least one product image'.tr);
      return;
    }

    final bool isInternetAvailable = await ConnectionUtils.isNetworkConnected();
    if (!isInternetAvailable) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      final Map<String, dynamic> params = <String, dynamic>{
        'company_name': txtCompany.text.trim(),
        'name': txtProductName.text.trim(),
        'category_id': selectedCategory?.id,
        'crop_ids[0]': selectedCrop?.id,
        'description': txtDescription.text.trim(),
        'dose': txtDose.text.trim(),
        if (txtYoutubeLink.text.trim().isNotEmpty)
          'youtube_video_link': txtYoutubeLink.text.trim(),
      };
      for (int index = 0; index < photoPaths.length; index++) {
        final String imagePath = photoPaths[index];
        params['images[$index]'] = await dio.MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split(Platform.pathSeparator).last,
        );
      }
      if (reelPath != null) {
        params['reel_video'] = await dio.MultipartFile.fromFile(
          reelPath!,
          filename: reelPath!.split(Platform.pathSeparator).last,
        );
      }

      Loader.load(true);
      final bool response = await productRepo.createProduct(
        params,
        Endpoints.createProduct,
      );
      if (response) {
        Get.find<ProductListController>().pagingController.refresh();
        Get.back();
      }
    } on dio.DioException catch (error) {
      Utility.showAPIError(error);
    } catch (error) {
      debugPrint('EXCEPTION=>${error.toString()}');
    } finally {
      Loader.load(false);
    }
  }

  @override
  void onClose() {
    txtProductName.dispose();
    txtCompany.dispose();
    txtDescription.dispose();
    txtDose.dispose();
    txtYoutubeLink.dispose();
    reelPreviewController?.dispose();
    super.onClose();
  }
}
