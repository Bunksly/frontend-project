import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("home"),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(child: Text("drawer")),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/donor');
                },
                title: Text("donor")),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/food-bank');
                },
                title: Text("foodbank")),
            ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                title: Text("home")),
          ],
        )),
      ),
    );
    ;
  }
}
