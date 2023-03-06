import 'package:flutter/material.dart';
import 'package:weather_application_project/hive_storage/weather_box.dart';
import 'package:weather_application_project/views/city_temperature_page.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  final weatherList = WeatherBox.getWeatherData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listLength = weatherList.length - 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'MOST RECENT',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Comfortaa',
            ),
          ),
        ),

        // ignore: prefer_const_literals_to_create_immutables
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: weatherList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CityPage(
                            city: weatherList.get(listLength - index)!.cityName,
                            temperature: weatherList
                                .get(listLength - index)!
                                .temperature
                                .toString())));
              },
              title: Text(
                'City Name: ${weatherList.get(listLength - index)!.cityName}',
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: 20),
              ),
              subtitle: Text(
                'Temperature: ${weatherList.get(listLength - index)!.temperature.toString()}',
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: 18),
              ),
              tileColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
