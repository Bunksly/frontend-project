import 'package:flutter/material.dart';

class PledgedItems extends StatelessWidget {
  final Map data;
  const PledgedItems({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pledged Items")),
        body: ListView.builder(
            itemCount: data["pledges"].length,
            itemBuilder: (BuildContext context, i) {
              final pledge = data["pledges"][i];
              return Text(pledge["charity"] +
                  ": " +
                  pledge["item"] +
                  "(${pledge["amount"]})");
            }));
  }
}
