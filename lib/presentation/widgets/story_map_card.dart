import 'package:fleegram/core/constants/api_constants.dart';
import 'package:fleegram/presentation/providers/map_picker_provider.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryMapCard extends StatelessWidget {
  final String name;
  final double lat;
  final double lon;

  const StoryMapCard({
    super.key,
    required this.name,
    required this.lat,
    required this.lon,
  });

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(lat, lon);

    return ChangeNotifierProvider(
      create: (_) => MapPickerProvider(latLng)..resolveAddress(latLng),
      child: _StoryMapView(name: name),
    );
  }
}

class _StoryMapView extends StatelessWidget {
  final String name;

  const _StoryMapView({required this.name});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapPickerProvider>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: provider.currentLatLng,
                  zoom: 15,
                ),
                onMapCreated: (c) => provider.controller = c,
                markers: {
                  Marker(
                    markerId: const MarkerId('picked'),
                    position: provider.currentLatLng,
                    infoWindow: InfoWindow(
                      title: name,
                      snippet: provider.address.isEmpty
                          ? 'Memuat alamat...'
                          : provider.address,
                    ),
                  ),
                },
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () async {
                  final lat = provider.currentLatLng.latitude;
                  final lon = provider.currentLatLng.longitude;

                  final googleMapsUrl = Uri.parse(
                    '${ApiConstants.mapsUrl}$lat,$lon',
                  );

                  if (await canLaunchUrl(googleMapsUrl)) {
                    await launchUrl(
                      googleMapsUrl,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    if (!context.mounted) return;
                    SnackbarHelper.show(
                      context,
                      'Gagal membuka Google Maps',
                      type: SnackbarType.error,
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_city_rounded, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          provider.city.isEmpty
                              ? 'Kota tidak tersedia'
                              : provider.city,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
