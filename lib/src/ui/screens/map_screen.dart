import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/src/domain/models/place_location.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: -7.70989,
      longitude: -37.8475,
    ),
    this.isReadOnly = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isReadOnly ? const Text('Veja') : const Text('Select a place'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedPosition == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedPosition),
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : selectPosition,
        markers: (_pickedPosition == null && !widget.isReadOnly)
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId('p1'),
                      position: _pickedPosition ?? widget.initialLocation.toLatLng(),
                    ),
                  },
      ),
    );
  }
}
