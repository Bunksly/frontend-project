import 'package:flutter/material.dart';
import 'package:frontend/profile_page.dart';




class FoodBank extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);
  static final String title = 'Foodbank Profile';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        primaryColor: Colors.green.shade100,
       // dividerColor: Colors.black,
      ),
      title: title,
      home: ProfilePage(),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     title: 'front page',
//     theme: ThemeData(
//       primarySwatch: Colors.amber,
//     ),
//     home:ProfilePage(),
//   ));
// }

