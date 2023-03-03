import 'package:flutter/material.dart';
import 'package:weather_application_project/hive_storage/weather_box.dart';

import 'city_temperature_page.dart';



class FavourPage extends StatefulWidget {
  const FavourPage({Key? key}) : super(key: key);

  @override
  State<FavourPage> createState() => _FavourPageState();
}

class _FavourPageState extends State<FavourPage> {
  final favourList = WeatherBox.getFavourData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final listLength = favourList.length-1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'WEATHER PRO',
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
        itemCount: favourList.length,
        itemBuilder: (context, index) {

          return Card(
            elevation: 10,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CityPage(
                            city:favourList.get(listLength-index)!.cityName,
                            temperature: favourList.get(listLength-index)!.temperature.toString()
                               )));
              },
              title: Text('City Name: ${favourList.get(listLength-index)!.cityName}',style: TextStyle(fontFamily: 'Comfortaa',fontSize: 20),),
              subtitle: Text('Temperature: ${favourList.get(listLength-index)!.temperature.toString()}',style: TextStyle(fontFamily: 'Comfortaa',fontSize: 18),),
              tileColor: Colors.white,
            ),
          );

        },
      ),
    );
  }
}
