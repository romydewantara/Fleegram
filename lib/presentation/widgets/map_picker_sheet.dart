import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
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

  bool _isResolvingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    _currentLatLng =
        widget.initialLatLng ?? const LatLng(-6.268847, 106.777884);
    _resolveAddress(_currentLatLng);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.mapPreview,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.markerSelected,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: _isResolvingCurrentLocation
                        ? null
                        : _moveToCurrentLocation,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
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
                    onTap: (pos) {
                      setState(() => _currentLatLng = pos);
                      _resolveAddress(pos);
                      _controller?.animateCamera(CameraUpdate.newLatLng(pos));
                    },
                    onCameraMove: (position) {
                      _isMovingCamera = true;
                      _cameraLatLng = position.target;
                      setState(() {
                        _currentLatLng = position.target;
                      });
                    },
                    onCameraIdle: () {
                      if (_isMovingCamera && _cameraLatLng != null) {
                        _resolveAddress(_cameraLatLng!);
                      }
                      _isMovingCamera = false;
                    },
                  ),

                  if (_isResolvingCurrentLocation)
                    Positioned.fill(
                      child: AbsorbPointer(
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.25),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  widget.onLocationPicked(_currentLatLng, _address);
                  context.pop();
                },
                child: Text(l10n.useLocation),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _moveToCurrentLocation() async {
    final l10n = AppLocalizations.of(context)!;
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      if (!mounted) return;

      final shouldOpen = await _askToEnableGps();
      if (shouldOpen) {
        await Geolocator.openLocationSettings();
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      if (!mounted) return;

      SnackbarHelper.show(
        context,
        l10n.locationDenied,
        type: SnackbarType.error,
        marginVertical: 80,
      );
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;

      SnackbarHelper.show(
        context,
        l10n.locationPermanentlyDenied,
        type: SnackbarType.error,
        marginVertical: 80,
      );

      await Geolocator.openAppSettings();
      return;
    }

    if (!mounted) return;
    setState(() => _isResolvingCurrentLocation = true);

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      final latLng = LatLng(position.latitude, position.longitude);

      await _controller?.animateCamera(CameraUpdate.newLatLng(latLng));

      setState(() => _currentLatLng = latLng);
      await _resolveAddress(latLng);
    } catch (_) {
      if (!mounted) return;

      SnackbarHelper.show(
        context,
        l10n.locationFailed,
        type: SnackbarType.error,
        marginVertical: 80,
      );
    } finally {
      if (mounted) {
        setState(() => _isResolvingCurrentLocation = false);
      }
    }
  }

  Future<bool> _askToEnableGps() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.enableLocation),
        content: Text(l10n.infoLocationService),
        actions: [
          TextButton(onPressed: () => ctx.pop(false), child: Text(l10n.cancel)),
          TextButton(onPressed: () => ctx.pop(true), child: Text(l10n.open)),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> _resolveAddress(LatLng latLng) async {
    final placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (!mounted) return;

    if (placemarks.isNotEmpty) {
      final p = placemarks.first;
      setState(() {
        _address = '${p.street}, ${p.subLocality}, ${p.locality}, ${p.country}';
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
