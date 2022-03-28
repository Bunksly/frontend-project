import 'package:flutter/material.dart';

class Karma extends StatelessWidget {
  final Map data;
  const Karma({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Karma")), body: Text(data["karma"]));
  }
}
