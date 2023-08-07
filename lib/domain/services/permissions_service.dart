import 'package:geolocator/geolocator.dart';

abstract interface class PermissionService{
  Future<bool> checkPermissions();
  Future<bool> requestPermissions();
}

class PermissionServiceImplementation implements PermissionService{
  @override
  Future<bool> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission != LocationPermission.denied && permission != LocationPermission.deniedForever;
  }

  @override
  Future<bool> requestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return await checkPermissions();
    }
    return true;
  }

}