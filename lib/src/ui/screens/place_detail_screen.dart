import 'package:flutter/material.dart';
import 'package:great_places/src/domain/models/place.dart';
import 'package:great_places/src/ui/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${place.location!.address}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return MapScreen(isReadOnly: true, initialLocation: place.location!);
                },
              ),
            ),
            icon: const Icon(Icons.map),
            label: const Text('See on map'),
          ),
        ],
      ),
    );
  }
}
