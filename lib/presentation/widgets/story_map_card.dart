import 'package:fleegram/core/constants/api_constants.dart';
import 'package:fleegram/l10n/app_localization.dart';
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
      create: (_) => MapPickerProvider(latLng),
      child: _StoryMapView(name: name),
    );
  }
}

class _StoryMapView extends StatefulWidget {
  final String name;

  const _StoryMapView({required this.name});

  @override
  State<_StoryMapView> createState() => _StoryMapViewState();
}

class _StoryMapViewState extends State<_StoryMapView> {
  late MapPickerProvider _provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapPickerProvider>().init();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = context.read<MapPickerProvider>();
  }

  @override
  void dispose() {
    _provider.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final latLng = context.select<MapPickerProvider, LatLng>(
      (p) => p.currentLatLng,
    );
    final address = context.select<MapPickerProvider, String>((p) => p.address);
    final city = context.select<MapPickerProvider, String>((p) => p.city);
    final provider = context.watch<MapPickerProvider>();

    final l10n = AppLocalizations.of(context)!;
    final color = Theme.of(context).colorScheme.tertiary;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: latLng, zoom: 14),
              onMapCreated: (c) => provider.controller = c,
              markers: {
                Marker(
                  markerId: const MarkerId('picked'),
                  position: latLng,
                  infoWindow: InfoWindow(
                    title: widget.name,
                    snippet: address.isEmpty ? l10n.loadAddress : address,
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
                final googleMapsUrl = Uri.parse(
                  '${ApiConstants.mapsUrl}'
                  '${latLng.latitude},${latLng.longitude}',
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
                    l10n.failedToOpenMaps,
                    type: SnackbarType.error,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.explore_rounded, size: 18, color: color),
                      const SizedBox(width: 6),
                      Text(
                        city.isEmpty ? l10n.cityNotAvailable : city,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 16, color: color),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
