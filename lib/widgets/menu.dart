// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.white],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: Center(
                child: Text(
              'MENU',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Comfortaa', fontSize: 40),
            )),
          ),
          ListTile(

            leading: const Icon(
              Icons.search,
            ),
            title: const Text(
              'Recent Searches',
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 20),

            ),
            onTap: (){
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
            ),
            title: const Text(
              'Favourites',
              style: TextStyle(fontFamily: 'Comfortaa', fontSize: 20),
            ),
            onTap: (){
              Navigator.pushNamed(context, '/favourite');
            },
          ),
        ],
      ),
    );
  }
}
