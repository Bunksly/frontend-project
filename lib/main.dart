import 'package:flutter/material.dart';
import 'package:frontend/donor.dart';
import 'package:frontend/profile_page.dart';
import 'package:frontend/user-profile.dart';
import 'package:frontend/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/newLogin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  await DotEnv.load(fileName: ".env");
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
          errorColor: secondaryColourCustom,
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
      initialRoute: '/login',
      routes: {
        '/donor': (context) => Donor(),
        '/food-bank': (context) => FoodBankPage(),
        '/profile': (context) => UserProfile(),
        '/login': ((context) => NewLogin()),
        '/signup': ((context) => SignUp())
      },
    );
  }
}
