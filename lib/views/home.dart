import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:weather_application_project/constants/constant.dart';

import 'package:weather_application_project/main.dart';
import 'package:weather_application_project/models/weather_data.dart';

import 'package:weather_application_project/provider/weather_provider.dart';

import 'package:weather_application_project/widgets/offline_page.dart';
import 'package:weather_application_project/widgets/menu.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  bool isConnected = false;
  bool isAlert = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getConnectivity();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WeatherProvider>(context, listen: false).getData('Pune');
    });
  }

  String msg = '';
  String iconUrl = '';

  @override
  void dispose() {
    // disposing states
    _scaffoldKey?.currentState?.dispose();
    subscription.cancel();
    super.dispose();
  }

  getnewData(String location) {
    Provider.of<WeatherProvider>(context, listen: false).getData(location);
  }

  getCurrentLocData() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Provider.of<WeatherProvider>(context, listen: false).getName(position);
  }

  TextEditingController controller = TextEditingController();
  GlobalKey<ScaffoldState>? _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      drawer: const Menu(),
      body: Consumer<WeatherProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const OfflinePage();
        } else {
          if (provider.result.current.tempC > 30) {
            msg = Constants.hot;
            iconUrl = Constants.hotIcon;
          } else if (provider.result.current.tempC >= 15 &&
              provider.result.current.tempC <= 30) {
            msg = Constants.mid;
            iconUrl = Constants.midIcon;
          } else {
            msg = Constants.cold;
            iconUrl = Constants.coldIcon;
          }
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 1), () {
                    setState(() {});
                  });
                },
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Text(provider.result.location.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 30,
                          ),
                          Text('${provider.result.current.tempC.toString()} °C',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 80,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                              'FEELS LIKE: ${provider.result.current.feelslikeC.toString()} °C',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.network(
                            iconUrl,
                            height: 150,
                            width: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(msg,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: controller,
                              onSubmitted: (value) async {
                                getnewData(value);

                                controller.clear();
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Comfortaa'),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(),
                                labelText: 'Enter Location',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: getCurrentLocData,
                            child: const Text(
                              'CURRENT LOCATION',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              markFavourite(provider.result.location.name,
                                  provider.result.current.tempC.toString());
                            },
                            child: const Text(
                              'MARK FAVOURITE',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  void markFavourite(String city, String temperature) {
    favourBox.add(WeatherData(cityName: city, temperature: temperature));
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isConnected = await InternetConnectionChecker().hasConnection;
      if (!isConnected && isAlert == false) {
        showDialogBox();
        setState(() {
          isAlert = true;
        });
      }
    });
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Internet'),
            content: const Text('Please connect to internet'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlert = false);
                  isConnected = await InternetConnectionChecker().hasConnection;
                  if (!isConnected) {
                    showDialogBox();
                    setState(() => isAlert = true);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ));
}
