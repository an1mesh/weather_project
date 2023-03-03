import 'package:flutter/material.dart';
import 'package:weather_application_project/constants/constant.dart';

class CityPage extends StatefulWidget {
  CityPage({required this.temperature, required this.city});

  String city;
  String temperature;

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  String msg = '';
  String iconUrl = '';


  @override
  Widget build(BuildContext context) {
    if(double.parse(widget.temperature)>30){
      msg = Constants.hot;
      iconUrl = Constants.hotIcon;
    }
    else if(double.parse(widget.temperature)>=15 && int.parse(widget.temperature)<=30){
      msg = Constants.mid;
      iconUrl = Constants.midIcon;
    }
    else{
      msg = Constants.cold;
      iconUrl = Constants.coldIcon;

    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                setState(() {});
              });
            },
            child: ListView(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(widget.city,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 50,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('${widget.temperature} °C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 80,
                              fontWeight: FontWeight.normal)),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.network(iconUrl,height: 150,width: 150,),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(msg,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 30,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
