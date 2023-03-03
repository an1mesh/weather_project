import 'package:flutter/foundation.dart';
import 'package:weather_application_project/models/location_name.dart';
import 'package:weather_application_project/models/temp.dart';
import 'package:http/http.dart' as http;

class Remote {
  Future<Temp> getAll(String location) async {
    final client = http.Client();
    final uri = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=1ecd31ddc9794582b3365523230103&q=$location&aqi=no');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final temp = await compute(tempFromJson, response.body.toString());
      print(temp.location.name);
      return temp;
    }
    return Future.error('failed');
  }

  Future<LocationName> getLocation(double lat, double lon) async {
    final client = http.Client();

    final uri = Uri.parse(
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lon&localityLanguage=en');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final locName =
          await compute(locationNameFromJson, response.body.toString());

      return locName;
    } else {
      return Future.error('failed');
    }
  }
}
