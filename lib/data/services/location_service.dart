import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/location_details_model.dart';
import 'package:krishi_mart/view/base/location_settings_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<LocationDetails?> getCoordinatesFromAddress(
    final String address,
  ) async {
    if (address.trim().isEmpty) {
      return null;
    }

    try {
      final List<Location> locations = await locationFromAddress(address);
      if (locations.isEmpty) {
        return null;
      }
      final Location location = locations.first;
      return LocationDetails(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address,
        state: '',
        district: '',
        postalCode: '',
      );
    } on NoResultFoundException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<LocationDetails?> getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission.isDenied) {
      permission = await Permission.location.request();
    }
    if (permission.isPermanentlyDenied || permission.isRestricted) {
      _showSettingsSheet(
        message:
            'Location permission is permanently denied. Enable it in Settings.',
        onOpenSettings: openAppSettings,
      );
      return null;
    }
    if (!permission.isGranted) {
      throw const LocationServiceException('Location permission was denied.');
    }

    final bool isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      _showSettingsSheet(
        message: 'Please enable location services and try again.',
        onOpenSettings: Geolocator.openLocationSettings,
      );
      return null;
    }

    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final Placemark place = placemarks.isEmpty
          ? const Placemark()
          : placemarks.first;
      final List<String> addressParts =
          <String?>[
                place.name,
                place.subLocality,
                place.locality,
                place.subAdministrativeArea,
                place.administrativeArea,
                place.country,
              ]
              .whereType<String>()
              .where((final String value) {
                return value.trim().isNotEmpty;
              })
              .toSet()
              .toList();

      return LocationDetails(
        latitude: position.latitude,
        longitude: position.longitude,
        address: addressParts.join(', '),
        state: place.administrativeArea ?? '',
        district: place.subAdministrativeArea ?? place.locality ?? '',
        postalCode: place.postalCode ?? '',
      );
    } on NoResultFoundException {
      return LocationDetails(
        latitude: position.latitude,
        longitude: position.longitude,
        address: '',
        state: '',
        district: '',
        postalCode: '',
      );
    }
  }

  void _showSettingsSheet({
    required final String message,
    required final Future<bool> Function() onOpenSettings,
  }) {
    Get.bottomSheet(
      LocationSettingsBottomSheet(
        message: message,
        onOpenSettings: () async {
          await onOpenSettings();
        },
      ),
      isDismissible: true,
    );
  }
}

class LocationServiceException implements Exception {
  const LocationServiceException(this.message);

  final String message;
}
