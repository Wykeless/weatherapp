import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class Location {
  late final double _latitude;
  late final double _longitude;
  bool _isDataRetrieved = false;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      _latitude = position.latitude;
      _longitude = position.longitude;

      _isDataRetrieved = true;
    } on Exception catch (e) {
      log('Error ' + e.toString());
      _isDataRetrieved = false;
      return Future.error('Something bad happened');
    }
  }

  double get getlongitudeValue {
    return _longitude;
  }

  double get getlatitudeValue {
    return _latitude;
  }

  bool isDataRetrived() {
    return _isDataRetrieved;
  }
}
