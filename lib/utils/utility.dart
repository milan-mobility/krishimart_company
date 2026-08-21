import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_mart/data/network/dio_exception.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/helpers/extensions/list_extension.dart';
import 'package:krishi_mart/routes/route_helper.dart';
import 'package:krishi_mart/view/base/custom_snack_bar.dart';
import 'package:krishi_mart/view/screens/company/home/controller/company_home_controller.dart';
import 'package:krishi_mart/view/screens/dealer/home/controller/dealer_home_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_compress/video_compress.dart';

class Utility {
  static bool checkIsNetworkUrl(final String url) {
    if (url.contains('http') || url.contains('https')) {
      return true;
    }
    return false;
  }

  static double getSafePadding({required final BuildContext context}) {
    final double bottom = MediaQuery.of(context).padding.bottom;
    if (bottom == 0) return 15; // normal case
    if (bottom >= 24 && bottom < 34) {
      return GetPlatform.isAndroid ? 10 : 0;
    }
    if (bottom >= 34) {
      return GetPlatform.isAndroid ? 15 : 0;
    }
    return bottom;
  }

  static void hideKeyboard(final BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void logout() {
    final SharedPreferenceHelper sharedPref =
        Get.find<SharedPreferenceHelper>();
    sharedPref.clear();
    if (Get.isRegistered<CompanyHomeController>()) {
      Get.delete<CompanyHomeController>(force: true);
    }
    if (Get.isRegistered<DealerHomeController>()) {
      Get.delete<DealerHomeController>(force: true);
    }
    Get.offAllNamed(RouteHelper.login);
  }

  static Future<String> convertBase64(final File imageFile) async {
    final List<int> imageBytes = await imageFile.readAsBytes();

    return base64Encode(imageBytes);
  }

  static Future<List<String>> getPhotos({final bool isMultiple = true}) async {
    List<String> images = <String>[];
    try {
      List<XFile> xFileList = <XFile>[];
      if (isMultiple) {
        xFileList = await ImagePicker().pickMultiImage(
          limit: 100,
          requestFullMetadata: true,
          imageQuality: 60,
        );
      } else {
        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          xFileList.add(image);
        }
      }
      if (xFileList.isNotNullOrEmpty()) {
        return images = xFileList.map((final XFile e) => e.path).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  static Future<List<String>> getFile() async {
    List<String> images = <String>[];
    try {
      List<PlatformFile> files = await FilePicker.pickFiles(
        type: FileType.custom,
        compressionQuality: 70,
        allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
      );
      if (files.isNotNullOrEmpty()) {
        images.addAll(files.map((e) => e.path ?? '').toList());
      }
      return images;
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  static Future<String?> selectVideo() async {
    try {
      final XFile? video = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 30),
      );
      if (video == null || video.path.isEmpty) return null;
      return video.path;
    } catch (error) {
      debugPrint('Video selection failed: $error');
      return null;
    }
  }

  static Future<String?> compressVideo(final String videoPath) async {
    try {
      final MediaInfo? compressedVideo = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
      );
      return compressedVideo?.path;
    } catch (error) {
      debugPrint('Video compression failed: $error');
      return null;
    }
  }

  static Future<void> makeCall(final String phone) async {
    final uri = Uri.parse("tel:$phone");
    await launchUrl(uri);
  }

  static Future<int> getAndroidOSVersion() async {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  }

  /*static Future<String?> selectVideo() async {
    try {
      final XFile? videoPath = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
        maxDuration: Duration(seconds: 20),
      );
      if (videoPath != null && videoPath.path.isNotNullAndEmpty()) {
        String? compressedPath = videoPath.path;
        if (GetPlatform.isAndroid) {
          Get.defaultDialog(
            title: 'Compressing Video',
            titleStyle: interW600,
            content: CompressWidget(),
          );

          compressedPath = await compressVideo(videoPath.path);
          Get.back();
          if (compressedPath != null) {
            return compressedPath;
          }
        } else {
          compressedPath = await compressVideo(videoPath.path);
          if (compressedPath != null) {
            return compressedPath;
          }
        }
      }
    } catch (e) {
      e.printError();
    }
    return null;
  }

  static Future<String?> compressVideo(final String path) async {
    final MediaInfo? result = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.MediumQuality,
    );
    if (result != null) {
      return result.path;
    }
    return null;
  }

  static Future<Uint8List?> getThumbnailBytes(final String videoPath) async {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 75,
    );
  }*/

  static void showAPIError(final DioException error) {
    try {
      final dynamic data = error.response?.data;

      // ✅ Handle structured API response
      if (data is Map) {
        // Validation errors can be returned either as `errors` or inside
        // `error.fields`, depending on the API endpoint.
        final dynamic nestedError = data['error'];
        final List<dynamic> validationErrors = <dynamic>[
          data['errors'],
          data['fields'],
          if (nestedError is Map) nestedError['fields'],
        ];

        for (final dynamic validationError in validationErrors) {
          final List<String> messages = _validationMessages(validationError);
          if (messages.isNotEmpty) {
            showErrorSnackBar(message: messages.join('\n'));
            return;
          }
        }

        // ✅ 2. Fallback to "message"
        final dynamic message = data['message'];
        if (message is String && message.isNotEmpty) {
          showErrorSnackBar(message: message);
          return;
        }
      }

      // ✅ 3. Your existing fallback logic (kept intact)
      if (error.response?.data is Map) {
        final MapEntry<dynamic, dynamic> firstItem = Map<dynamic, dynamic>.of(
          error.response?.data,
        ).entries.first;

        String message = '';

        if (firstItem.value is List) {
          if (firstItem.value[0] is Map) {
            final MapEntry<dynamic, dynamic> field = Map<dynamic, dynamic>.of(
              firstItem.value[0],
            ).entries.first;

            if (field.value is List) {
              if (field.value[0] is String) {
                message = field.value[0];
              } else {
                final MapEntry<dynamic, dynamic> mapField =
                    Map<dynamic, dynamic>.of(field.value[0]).entries.first;

                if (mapField.value is List) {
                  message = mapField.value[0];
                } else if (mapField.value is String) {
                  message = mapField.value;
                }
              }
            } else if (field.value is Map) {
              message = 'Something went wrong';
            } else {
              message = field.value.toString();
            }
          } else {
            message = firstItem.value[0].toString();
          }
        } else if (firstItem.value is String) {
          message = firstItem.value;
        }

        if (message.isNotEmpty) {
          showErrorSnackBar(message: message);
          return;
        }
      }
    } catch (e) {
      final String message = DioExceptions.fromDioError(error).message;
      showErrorSnackBar(message: message);
    }
  }

  static List<String> _validationMessages(final dynamic fields) {
    if (fields is! Map) return <String>[];

    final List<String> messages = <String>[];
    for (final dynamic value in fields.values) {
      if (value is String && value.trim().isNotEmpty) {
        messages.add(value);
      } else if (value is List) {
        messages.addAll(
          value.whereType<String>().where(
            (final String value) => value.trim().isNotEmpty,
          ),
        );
      }
    }
    return messages;
  }
}
