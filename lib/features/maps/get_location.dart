import 'package:location/location.dart';

final Location _location = Location();

Future<LocationData> initializeLocation() async {
  bool serviceEnabled = await _location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await _location.requestService();
    if (!serviceEnabled) return LocationData.fromMap({});
  }

  PermissionStatus permissionGranted = await _location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await _location.requestPermission();
    if (permissionGranted != PermissionStatus.granted)
      return LocationData.fromMap({});
  }

  final currentLocation = await _location.getLocation();

  return currentLocation;
}
