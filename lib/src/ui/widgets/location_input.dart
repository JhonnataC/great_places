import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/src/data/repositories/location_repository.dart';
import 'package:great_places/src/ui/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function(LatLng) onSelectPosition;

  const LocationInput({super.key, required this.onSelectPosition});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool isLoadingImage = false;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationRepository.generateLocationPreviewUrl(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
      isLoadingImage = false;
    });
  }

  Future<void> getCurrentLocation() async {
    try {
      setState(() => isLoadingImage = true);

      final locData = await Location().getLocation();

      if (locData.latitude == null || locData.longitude == null) return;

      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPosition(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }
  
  Future<void> selectOnMap() async {
    setState(() => isLoadingImage = true);

    final selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(),
      ),
    );

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text('Location not specified')
              : isLoadingImage
                  ? const CircularProgressIndicator()
                  : Image.network(
                      _previewImageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              label: const Text('Current Location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: selectOnMap,
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            )
          ],
        ),
      ],
    );
  }
}
