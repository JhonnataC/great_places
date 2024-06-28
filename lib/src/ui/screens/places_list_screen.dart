import 'package:flutter/material.dart';
import 'package:great_places/src/data/utils/app_routes.dart';
import 'package:great_places/src/ui/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('No places added!'),
                    ),
                    builder: (context, greatPlaces, child) =>
                        greatPlaces.itemsCount == 0
                            ? child!
                            : ListView.builder(
                                itemCount: greatPlaces.itemsCount,
                                itemBuilder: (context, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.itemByIndex(i).title),
                                  subtitle: Text(
                                      '${greatPlaces.itemByIndex(i).location!.address}'),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.PLACE_DETAIL,
                                      arguments: greatPlaces.itemByIndex(i),
                                    );
                                  },
                                ),
                              ),
                  ),
      ),
    );
  }
}
