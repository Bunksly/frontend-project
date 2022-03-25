import 'package:flutter/material.dart';
import 'package:frontend/home.dart';
import 'package:frontend/donor.dart';
import 'package:frontend/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/login.dart';
import 'package:frontend/newLogin.dart';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor swatchColourCustom = MaterialColor(0xff749C75, color);
MaterialColor scaffoldBackgroundColourCustom = MaterialColor(0x30ECE0E0, color);
MaterialColor buttonColourCustom = MaterialColor(0xff457B9D, color);
MaterialColor secondaryColourCustom = MaterialColor(0xffC17767, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: swatchColourCustom,
          accentColor: swatchColourCustom,
          primarySwatch: swatchColourCustom,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: scaffoldBackgroundColourCustom,
          checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(Color(0xffC17767))),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(buttonColourCustom))),
          buttonTheme: ButtonTheme.of(context)
              .copyWith(buttonColor: buttonColourCustom)),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/donor': (context) => Donor(),
        '/food-bank': (context) => FoodBankPage(),
        '/login': ((context) => newLogin())
      },
    );
  }
}
