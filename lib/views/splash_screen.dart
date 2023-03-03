import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_application_project/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Home()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                color: Colors.white,
              height: 200,
              width: 200,
              child: Image.network('https://cdn-icons-png.flaticon.com/512/9176/9176568.png')
            ),
            const SizedBox(height: 40,),
            Text('WEATHER PRO',style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 30,
              letterSpacing: 1,
            ),)
          ],
        ),
      ),
    );
  }
}
