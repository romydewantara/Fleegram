import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerProvider extends ChangeNotifier {
  LatLng currentLatLng;
  String address = '';

  GoogleMapController? controller;

  LatLng? cameraLatLng;
  bool isMovingCamera = false;
  bool isResolvingCurrentLocation = false;

  MapPickerProvider(this.currentLatLng);

  void setLatLng(LatLng latLng) {
    currentLatLng = latLng;
    notifyListeners();
  }

  void setResolving(bool value) {
    isResolvingCurrentLocation = value;
    notifyListeners();
  }

  Future<void> resolveAddress(LatLng latLng) async {
    final placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;
      address = '${p.street}, ${p.subLocality}, ${p.locality}, ${p.country}';
      notifyListeners();
    }
  }
}
