import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerSheet extends StatefulWidget {
  final LatLng? initialLatLng;
  final Function(LatLng, String) onLocationPicked;

  const MapPickerSheet({
    super.key,
    this.initialLatLng,
    required this.onLocationPicked,
  });

  @override
  State<MapPickerSheet> createState() => _MapPickerSheetState();
}

class _MapPickerSheetState extends State<MapPickerSheet> {
  late LatLng _currentLatLng;
  String _address = '';
  GoogleMapController? _controller;

  LatLng? _cameraLatLng;
  bool _isMovingCamera = false;

  @override
  void initState() {
    super.initState();
    _currentLatLng =
        widget.initialLatLng ?? const LatLng(-6.268847, 106.777884);
    _resolveAddress(_currentLatLng);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Map preview',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your content will show up here',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: _moveToCurrentLocation,
                  ),
                ],
              ),
            ),

            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentLatLng,
                  zoom: 15,
                ),
                onMapCreated: (c) => _controller = c,
                markers: {
                  Marker(
                    markerId: const MarkerId('picked'),
                    position: _currentLatLng,
                    draggable: true,
                    infoWindow: InfoWindow(title: _address),
                    onDragEnd: (pos) {
                      setState(() => _currentLatLng = pos);
                      _resolveAddress(pos);
                    },
                  ),
                },

                // TAP → marker pindah
                onTap: (pos) {
                  setState(() => _currentLatLng = pos);
                  _resolveAddress(pos);
                  _controller?.animateCamera(CameraUpdate.newLatLng(pos));
                },

                // GESER MAP → marker ikut ke tengah
                onCameraMove: (position) {
                  _isMovingCamera = true;
                  _cameraLatLng = position.target;
                  setState(() {
                    _currentLatLng = position.target;
                  });
                },

                // KAMERA BERHENTI → ambil alamat
                onCameraIdle: () {
                  if (_isMovingCamera && _cameraLatLng != null) {
                    _resolveAddress(_cameraLatLng!);
                  }
                  _isMovingCamera = false;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  widget.onLocationPicked(_currentLatLng, _address);
                  context.pop();
                },
                child: const Text('Use this location'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _moveToCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    final latLng = LatLng(position.latitude, position.longitude);

    _controller?.animateCamera(CameraUpdate.newLatLng(latLng));

    setState(() => _currentLatLng = latLng);
    _resolveAddress(latLng);
  }

  Future<void> _resolveAddress(LatLng latLng) async {
    final placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;
      setState(() {
        _address = '${p.street}, ${p.subLocality}, ${p.locality}, ${p.country}';
      });
    }
  }
}
