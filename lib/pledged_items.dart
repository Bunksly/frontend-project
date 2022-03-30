import 'package:flutter/material.dart';

class PledgedItems extends StatelessWidget {
  final List data;
  const PledgedItems({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
        appBar: AppBar(title: Text("Pledged Items")),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, i) {
              final pledge = data[i];
              return Text(pledge["charity_name"] +
                  ":  " +
                  pledge["item_name"] +
                  "(${pledge["quantity_available"]})");
            }));
  }
}
