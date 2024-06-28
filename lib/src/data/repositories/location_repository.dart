import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const String GOOGLE_API_KEY = 'AIzaSyA4ravnp__WWCNCw6utOZmlDZx0r-M-itI';

class LocationRepository {
  static String generateLocationPreviewUrl(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$latitude,$longitude'
        '&zoom=13&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Clabel:You%7C$latitude,$longitude'
        '&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
