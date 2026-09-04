import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/controllers/common_controller.dart';
import 'package:krishi_mart/data/model/category_model.dart';
import 'package:krishi_mart/data/model/id_name_model.dart';
import 'package:krishi_mart/data/model/product_model.dart';
import 'package:krishi_mart/data/network/api_end_points.dart';
import 'package:krishi_mart/data/network/connection.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/data/repository/product_repo.dart';
import 'package:krishi_mart/utils/message_constant.dart';
import 'package:krishi_mart/utils/app_enums.dart';
import 'package:krishi_mart/utils/utility.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/base/loader.dart';
import 'package:krishi_mart/view/screens/company/product/list/controller/product_controller.dart';
import 'package:video_player/video_player.dart';

class EditDealerProductController extends GetxController {
  EditDealerProductController(
    this.commonController,
    this.productRepo,
    this.sharedPref,
    this.product,
    this.updateEndpoint,
  );

  final CommonController commonController;
  final ProductRepo productRepo;
  final SharedPreferenceHelper sharedPref;
  final Product product;
  final String? updateEndpoint;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController txtProductName = TextEditingController();
  final TextEditingController txtCompany = TextEditingController();
  final TextEditingController txtFarmerName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDose = TextEditingController();
  final TextEditingController txtYoutubeLink = TextEditingController();
  final List<String> photoPaths = <String>[];
  final List<PrimaryImage> existingImages = <PrimaryImage>[];
  String? reelPath;
  VideoPlayerController? reelPreviewController;
  bool isLoadingExistingReel = false;
  String? reelLoadError;
  bool hasRemovedExistingReel = false;
  bool isSelectingReel = false;
  bool isCompressingReel = false;
  final List<IdName> selectedCrops = <IdName>[];
  Category? selectedCategory;
  IdName? selectedTaluka;
  IdName? selectedVillage;

  bool get isDemoProduct => product.isDemo ?? false;
  bool get isProcessingReel => isSelectingReel || isCompressingReel;
  bool get hasExistingServerReel =>
      (product.reelVideoUrl?.trim().isNotEmpty ?? false) &&
      !hasRemovedExistingReel;
  String get _updateEndpoint => sharedPref.getUserRole == UserType.dealer.name
      ? Endpoints.updateDealerProduct(product.id ?? 0)
      : updateEndpoint ?? Endpoints.updateCompanyProduct(product.id ?? 0);

  @override
  void onInit() {
    super.onInit();
    txtProductName.text = product.name ?? '';
    final String? topLevelCompanyName = product.companyName?.trim();
    txtCompany.text = topLevelCompanyName?.isNotEmpty == true
        ? topLevelCompanyName!
        : product.company?.companyName ?? product.brand?.name ?? '';
    txtFarmerName.text = product.demoFarmerName ?? '';
    txtDescription.text = product.description ?? '';
    txtDose.text = product.dose ?? '';
    txtYoutubeLink.text = product.youtubeVideoLink ?? '';
    existingImages.addAll(
      (product.images ?? <PrimaryImage>[]).where(
        (final PrimaryImage image) =>
            (image.imageUrl ?? image.image)?.isNotEmpty ?? false,
      ),
    );
    if (existingImages.isEmpty && product.primaryImage != null) {
      final PrimaryImage image = product.primaryImage!;
      if ((image.imageUrl ?? image.image)?.isNotEmpty ?? false) {
        existingImages.add(image);
      }
    }
    _initializeExistingReel();
    _loadOptionsAndPrefill();
  }

  Future<void> _initializeExistingReel() async {
    final String? reelUrl = product.reelVideoUrl?.trim();
    if (reelUrl == null || reelUrl.isEmpty) return;
    isLoadingExistingReel = true;
    reelLoadError = null;
    final VideoPlayerController previewController =
        VideoPlayerController.networkUrl(Uri.parse(_remoteMediaUrl(reelUrl)));
    reelPreviewController = previewController;
    try {
      await previewController.initialize();
    } catch (error) {
      debugPrint('Unable to load existing reel: $error');
      reelLoadError = 'Unable to load reel preview'.tr;
      await previewController.dispose();
      if (reelPreviewController == previewController) {
        reelPreviewController = null;
      }
    }
    isLoadingExistingReel = false;
    update();
  }

  String _remoteMediaUrl(final String path) {
    final String normalizedPath = path.trim();
    return normalizedPath.startsWith('http')
        ? normalizedPath
        : '${Endpoints.imageUrl}$normalizedPath';
  }

  Future<void> _loadOptionsAndPrefill() async {
    await Future.wait<void>(<Future<void>>[
      commonController.getCategories(),
      commonController.getCrops(),
    ]);
    final int? categoryId = product.categoryId ?? product.category?.id;
    for (final Category category in commonController.categories) {
      if (category.id == categoryId ||
          (categoryId == null && category.name == product.category?.name)) {
        selectedCategory = category;
        break;
      }
    }
    selectedCrops.addAll(
      (product.crops ?? <Crops>[]).map(
        (final Crops crop) => IdName(id: crop.id, name: crop.name),
      ),
    );
    final int? districtId =
        commonController.userProfileModel?.data?.profile?.districtId;
    if (isDemoProduct && districtId != null) {
      await commonController.getTalukas(districtId);
      selectedTaluka = _itemById(commonController.talukas, product.talukaId);
      if (selectedTaluka != null) {
        await commonController.getVillages(selectedTaluka?.id);
        selectedVillage = _itemById(
          commonController.villages,
          product.villageId,
        );
      }
    }
    update();
  }

  IdName? _itemById(final List<IdName> items, final int? id) {
    for (final IdName item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  void selectCategory(final Category? category) {
    selectedCategory = category;
    update();
  }

  void selectCrops(final List<IdName> crops) {
    selectedCrops
      ..clear()
      ..addAll(crops);
    update();
  }

  Future<void> selectTaluka(final IdName? taluka) async {
    selectedTaluka = taluka;
    selectedVillage = null;
    update();
    await commonController.getVillages(taluka?.id);
    update();
  }

  void selectVillage(final IdName? village) {
    selectedVillage = village;
    update();
  }

  Future<void> selectPhotos() async {
    photoPaths.addAll(await Utility.getPhotos());
    update();
  }

  void removePhotoAt(final int index) {
    photoPaths.removeAt(index);
    update();
  }

  String remoteMediaUrl(final String path) => _remoteMediaUrl(path);

  Future<void> deleteExistingImage(final PrimaryImage image) async {
    final int? productId = product.id;
    final int? imageId = image.id;
    if (productId == null || imageId == null) {
      showErrorSnackBar(message: 'Unable to delete image'.tr);
      return;
    }
    if (!await ConnectionUtils.isNetworkConnected()) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }

    try {
      Loader.load(true);
      final bool deleted = await productRepo.deleteProductImage(
        role: sharedPref.getUserRole,
        productId: productId,
        imageId: imageId,
      );
      if (deleted) {
        existingImages.removeWhere(
          (final PrimaryImage item) => item.id == imageId,
        );
        await Get.find<ProductListController>().refreshProducts();
        update();
      }
    } on dio.DioException catch (error) {
      Utility.showAPIError(error);
    } finally {
      Loader.load(false);
    }
  }

  Future<void> selectReel() async {
    if (hasExistingServerReel) {
      showErrorSnackBar(
        message: 'Remove the existing reel before uploading a new one'.tr,
      );
      return;
    }
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
    previewController.value.isPlaying
        ? previewController.pause()
        : previewController.play();
    update();
  }

  Future<void> removeReel() async {
    if (hasExistingServerReel) {
      final int? productId = product.id;
      if (productId == null) {
        showErrorSnackBar(message: 'Unable to delete reel'.tr);
        return;
      }
      if (!await ConnectionUtils.isNetworkConnected()) {
        showErrorSnackBar(
          title: MessageConstant.netWorkTitle,
          message: MessageConstant.networkError,
        );
        return;
      }
      try {
        Loader.load(true);
        final bool deleted = await productRepo.deleteProductReel(
          productId: productId,
        );
        if (!deleted) return;
        hasRemovedExistingReel = true;
        await Get.find<ProductListController>().refreshProducts();
      } on dio.DioException catch (error) {
        Utility.showAPIError(error);
        return;
      } finally {
        Loader.load(false);
      }
    }
    await reelPreviewController?.dispose();
    reelPreviewController = null;
    reelPath = null;
    update();
  }

  Future<void> updateProduct() async {
    if (!(formKey.currentState?.validate() ?? false) ||
        selectedCategory == null ||
        selectedCrops.isEmpty ||
        (isDemoProduct &&
            (selectedTaluka == null || selectedVillage == null))) {
      showErrorSnackBar(message: 'Please complete all required fields'.tr);
      return;
    }
    if (!await ConnectionUtils.isNetworkConnected()) {
      showErrorSnackBar(
        title: MessageConstant.netWorkTitle,
        message: MessageConstant.networkError,
      );
      return;
    }
    try {
      final Map<String, dynamic> params = <String, dynamic>{
        '_method': 'PUT',
        'company_name': txtCompany.text.trim(),
        'name': txtProductName.text.trim(),
        'category_id': selectedCategory?.id,
        'description': txtDescription.text.trim(),
        'dose': txtDose.text.trim(),
        if (txtYoutubeLink.text.trim().isNotEmpty)
          'youtube_video_link': txtYoutubeLink.text.trim(),
        if (isDemoProduct) ...<String, dynamic>{
          'farmer_name': txtFarmerName.text.trim(),
          'taluka_id': selectedTaluka?.id,
          'village_id': selectedVillage?.id,
        },
      };
      for (int index = 0; index < selectedCrops.length; index++) {
        params['crop_ids[$index]'] = selectedCrops[index].id;
      }
      for (int index = 0; index < photoPaths.length; index++) {
        final String path = photoPaths[index];
        params['images[$index]'] = await dio.MultipartFile.fromFile(
          path,
          filename: path.split(Platform.pathSeparator).last,
        );
      }
      if (reelPath != null) {
        params['reel_video'] = await dio.MultipartFile.fromFile(
          reelPath!,
          filename: reelPath!.split(Platform.pathSeparator).last,
        );
      }
      Loader.load(true);
      final bool updated = await productRepo.updateProduct(
        params,
        _updateEndpoint,
      );
      if (updated) {
        await Get.find<ProductListController>().refreshProducts();
        Get.back();
      }
    } on dio.DioException catch (error) {
      Utility.showAPIError(error);
    } finally {
      Loader.load(false);
    }
  }

  @override
  void onClose() {
    txtProductName.dispose();
    txtCompany.dispose();
    txtFarmerName.dispose();
    txtDescription.dispose();
    txtDose.dispose();
    txtYoutubeLink.dispose();
    reelPreviewController?.dispose();
    super.onClose();
  }
}
