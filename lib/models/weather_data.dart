import 'package:hive/hive.dart';
part 'weather_data.g.dart';

@HiveType(typeId: 0)
class WeatherData{
  WeatherData({required this.cityName,required this.temperature});
  @HiveField(0)
  String cityName;

  @HiveField(1)
  String temperature;
}