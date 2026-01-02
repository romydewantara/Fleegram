import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerProvider extends ChangeNotifier {
  LatLng currentLatLng;
  String address = '';
  String city = '';

  GoogleMapController? controller;

  LatLng? cameraLatLng;
  bool isMovingCamera = false;
  bool isResolvingCurrentLocation = false;
  bool _initialized = false;

  MapPickerProvider(this.currentLatLng);

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    await resolveAddress(currentLatLng);
  }

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
      city = p.subAdministrativeArea?.isNotEmpty == true
          ? p.subAdministrativeArea!
          : p.locality ?? '';
      address = '${p.street}, ${p.subLocality}, ${p.locality}, ${p.country}';
      notifyListeners();
    }
  }

  void disposeController() {
    controller?.dispose();
    controller = null;
  }
}
