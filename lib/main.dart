import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_application_project/models/weather_data.dart';
import 'package:weather_application_project/provider/weather_provider.dart';
import 'package:weather_application_project/views/favourite_page.dart';
import 'package:weather_application_project/views/search_history.dart';
import 'package:weather_application_project/views/splash_screen.dart';
import 'views/home.dart';

late Box weatherBox;
late Box favourBox;

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherDataAdapter());
  weatherBox = await Hive.openBox<WeatherData>('weather_box');
  favourBox = await Hive.openBox<WeatherData>('favour_box');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/search': (context) => const SearchHistory(),
        '/favourite':(context) => const FavourPage(),
      },
    );
  }
}
