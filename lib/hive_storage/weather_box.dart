import 'package:hive_flutter/hive_flutter.dart';
import '../models/weather_data.dart';

class WeatherBox{
 static Box<WeatherData> getWeatherData() {
   return Hive.box<WeatherData>('weather_box');
 }
 static Box<WeatherData> getFavourData(){
   return Hive.box<WeatherData>('favour_box');
 }
}