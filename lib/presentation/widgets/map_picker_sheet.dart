import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/map_picker_provider.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPickerSheet extends StatelessWidget {
  final LatLng? initialLatLng;
  final Function(LatLng, String) onLocationPicked;

  const MapPickerSheet({
    super.key,
    this.initialLatLng,
    required this.onLocationPicked,
  });

  @override
  Widget build(BuildContext context) {
    final start = initialLatLng ?? const LatLng(-6.268847, 106.777884);

    return ChangeNotifierProvider(
      create: (_) => MapPickerProvider(start)..resolveAddress(start),
      child: _View(onLocationPicked: onLocationPicked),
    );
  }
}

class _View extends StatelessWidget {
  final Function(LatLng, String) onLocationPicked;

  const _View({required this.onLocationPicked});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.watch<MapPickerProvider>();

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
                    onPressed: provider.isResolvingCurrentLocation
                        ? null
                        : () => _moveToCurrentLocation(context, provider),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: provider.currentLatLng,
                      zoom: 15,
                    ),
                    onMapCreated: (c) => provider.controller = c,
                    markers: {
                      Marker(
                        markerId: const MarkerId('picked'),
                        position: provider.currentLatLng,
                        draggable: true,
                        infoWindow: InfoWindow(title: provider.address),
                        onDragEnd: (pos) {
                          provider.setLatLng(pos);
                          provider.resolveAddress(pos);
                        },
                      ),
                    },
                    onTap: (pos) {
                      provider.setLatLng(pos);
                      provider.resolveAddress(pos);
                      provider.controller?.animateCamera(
                        CameraUpdate.newLatLng(pos),
                      );
                    },
                    onCameraMove: (position) {
                      provider.isMovingCamera = true;
                      provider.cameraLatLng = position.target;
                      provider.currentLatLng = position.target;
                    },
                    onCameraIdle: () {
                      if (provider.isMovingCamera &&
                          provider.cameraLatLng != null) {
                        provider.resolveAddress(provider.cameraLatLng!);
                      }
                      provider.isMovingCamera = false;
                    },
                  ),

                  if (provider.isResolvingCurrentLocation)
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
                  onLocationPicked(provider.currentLatLng, provider.address);
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

  Future<void> _moveToCurrentLocation(
    BuildContext context,
    MapPickerProvider p,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!context.mounted) return;

    if (!serviceEnabled) {
      final shouldOpen = await _askToEnableGps(context);

      if (!context.mounted) return;

      if (shouldOpen) {
        await Geolocator.openLocationSettings();
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (!context.mounted) return;

    if (permission == LocationPermission.denied) {
      SnackbarHelper.show(
        context,
        l10n.locationDenied,
        type: SnackbarType.error,
        marginVertical: 80,
      );
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      SnackbarHelper.show(
        context,
        l10n.locationPermanentlyDenied,
        type: SnackbarType.error,
        marginVertical: 80,
      );
      await Geolocator.openAppSettings();
      return;
    }

    p.setResolving(true);

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latLng = LatLng(position.latitude, position.longitude);

      await p.controller?.animateCamera(CameraUpdate.newLatLng(latLng));

      p.setLatLng(latLng);
      await p.resolveAddress(latLng);
    } catch (_) {
      if (!context.mounted) return;

      SnackbarHelper.show(
        context,
        l10n.locationFailed,
        type: SnackbarType.error,
        marginVertical: 80,
      );
    } finally {
      p.setResolving(false);
    }
  }

  Future<bool> _askToEnableGps(BuildContext context) async {
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
}
