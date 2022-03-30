import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PledgedItems extends StatefulWidget {
  final List data;
  const PledgedItems({Key? key, required this.data}) : super(key: key);

  @override
  State<PledgedItems> createState() => _PledgedItemsState();
}

class _PledgedItemsState extends State<PledgedItems> {
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
        appBar: AppBar(title: Text("Pledged Items")),
        body: Center(
            child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, i) {
                  final pledge = widget.data[i];
                  return Card(
                      child: ListTile(
                    leading: Text(pledge["charity_name"]),
                    title: Center(child: Text(pledge["item_name"].toString())),
                    subtitle: Center(
                        child: Text("amount pledged: " +
                            pledge["quantity_available"].toString())),
                    trailing: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            widget.data.remove(pledge);
                          });
                          await delete(Uri.parse(
                              "https://charity-project-hrmjjb.herokuapp.com/api/donations/${pledge["donation_id"]}"));
                        },
                        child: Text("Revoke")),
                  ));

                  //Text(pledge["charity_name"] +
                  //     ":  " +
                  //     pledge["item_name"] +
                  //     "(${pledge["quantity_available"]})");
                })));
  }
}
