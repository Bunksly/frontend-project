import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/donor');
            },
            child: Text("donor")),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/food-bank');
            },
            child: Text("foodbank"))
      ],
    )));
  }
}
