import 'package:flutter/cupertino.dart';

import 'package:geolocator/geolocator.dart';
import 'package:weather_application_project/models/location_name.dart';
import '../hive_storage/weather_box.dart';
import '../models/temp.dart';
import '../models/weather_data.dart';
import '../services/remote.dart';

class WeatherProvider with ChangeNotifier {
  Remote _service = Remote();
  bool isLoading = false;
  late Temp _result;
  late LocationName _positionResult;

  Temp get result => _result;

  Future<void> getData(String location) async {
    isLoading = true;
    notifyListeners();
    _result = await _service.getAll(location);
    final weatherBox = WeatherBox.getWeatherData();
    weatherBox.add(WeatherData(
        cityName: _result.location.name,
        temperature: _result.current.tempC.toString()));

    isLoading = false;
    notifyListeners();
  }

  Future<void> getName(Position position) async {
    _positionResult =
        await _service.getLocation(position.latitude, position.longitude);
    isLoading = true;
    notifyListeners();
    _result = await _service.getAll(_positionResult.city);
    isLoading = false;
    notifyListeners();
  }
}
