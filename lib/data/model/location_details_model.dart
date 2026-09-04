class LocationDetails {
  const LocationDetails({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.state,
    required this.district,
    required this.postalCode,
  });

  final double latitude;
  final double longitude;
  final String address;
  final String state;
  final String district;
  final String postalCode;
}
