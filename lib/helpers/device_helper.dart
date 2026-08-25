import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdHelper {
  static const String _deviceIdKey = 'persistent_device_id';

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static const IOSOptions _iosOptions = IOSOptions(
    // Accessible after the device is unlocked once after restarting.
    // This value will not migrate to another physical device.
    accessibility: KeychainAccessibility.first_unlock_this_device,

    // Keep it local to this device instead of syncing with iCloud.
    synchronizable: false,
  );

  static Future<String?> getDeviceId() async {
    if (Platform.isAndroid) {
      return _getAndroidDeviceId();
    }

    if (Platform.isIOS) {
      return _getPersistentIOSDeviceId();
    }

    return null;
  }

  static Future<String?> _getAndroidDeviceId() async {
    try {
      return await const AndroidId().getId();
    } on MissingPluginException {
      debugPrint('Failed to get Android ID: MissingPluginException');
      return null;
    } on PlatformException catch (e) {
      debugPrint('Failed to get Android ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Failed to get Android ID: $e');
      return null;
    }
  }

  static Future<String?> _getPersistentIOSDeviceId() async {
    try {
      // First check whether an ID already exists in Keychain.
      String? deviceId = await _secureStorage.read(
        key: _deviceIdKey,
        iOptions: _iosOptions,
      );

      if (deviceId != null && deviceId.trim().isNotEmpty) {
        debugPrint("IOS DEVICE ID EXISTING=>$deviceId");
        return deviceId;
      }

      // Create an ID only on the first installation.
      deviceId = const Uuid().v4();

      await _secureStorage.write(
        key: _deviceIdKey,
        value: deviceId,
        iOptions: _iosOptions,
      );
      debugPrint("IOS DEVICE ID NEW GENERATE=>$deviceId");
      return deviceId;
    } on PlatformException catch (e) {
      debugPrint(
        'Failed to access iOS Keychain: '
        '${e.code} - ${e.message}',
      );
      return null;
    } catch (e) {
      debugPrint('Failed to generate persistent iOS device ID: $e');
      return null;
    }
  }
}
