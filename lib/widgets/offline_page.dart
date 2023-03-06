import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  late StreamSubscription subscription;
  bool isConnected = false;
  bool isAlert = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
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
