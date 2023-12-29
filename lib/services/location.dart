import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Location {
  double? latitude, longitude;
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied)
      permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print('permission denied');
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
