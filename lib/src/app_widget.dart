import 'package:flutter/material.dart';
import 'package:great_places/src/data/utils/app_routes.dart';
import 'package:great_places/src/ui/providers/great_places.dart';
import 'package:great_places/src/ui/screens/place_detail_screen.dart';
import 'package:great_places/src/ui/screens/place_form_screen.dart';
import 'package:great_places/src/ui/screens/places_list_screen.dart';
import 'package:provider/src/change_notifier_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: 
        ThemeData().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
        ),
        routes: {
          AppRoutes.PLACES_LIST_SCREEN: (context) => const PlacesListScreen(),
          AppRoutes.PLACE_FORM: (context) => const PlaceForm(),
          AppRoutes.PLACE_DETAIL: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}