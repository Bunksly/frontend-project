import 'package:flutter/material.dart';
import 'package:frontend/home.dart';
import 'package:frontend/donor.dart';
import 'package:frontend/FoodBankMain.dart';
import 'package:frontend/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/donor': (context) => Donor(),
        '/food-bank': (context) => FoodBank(),
      },
    );
  }
}
