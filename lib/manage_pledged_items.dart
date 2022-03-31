import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ManagePledges extends StatefulWidget {
  final String? userId;
  const ManagePledges({Key? key, required this.userId}) : super(key: key);

  @override
  State<ManagePledges> createState() => _ManagePledgesState();
}

class _ManagePledgesState extends State<ManagePledges> {
  List pledgesList = [];

  void fetchPledges() async {
    final rawData = await get(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/charities/donations/${widget.userId}"));
    final data = jsonDecode(rawData.body);
    final output = data["donorPledges"] as List;
    setState(() {
      pledgesList = output;
    });
  }

  void deletePledges(pledge) async {
    final rawData = await delete(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/donations/${pledge["donation_id"]}"));
    print(rawData.statusCode);
  }

  @override
  void initState() {
    super.initState();
    fetchPledges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manage pledged items"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "User",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          "Item(Amount)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Center(
                                child: Text(
                          "Fulfilled?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                      ],
                    ))),
            Expanded(
                flex: 12,
                child: ListView.builder(
                    itemCount: pledgesList.length,
                    itemBuilder: (BuildContext context, i) {
                      final pledge = pledgesList[i];
                      return Card(
                        child: ListTile(
                            leading: Text(pledge["username"]),
                            title: Center(child: Text(pledge["item_name"])),
                            subtitle: Center(
                                child: Text(
                                    pledge["quantity_available"].toString())),
                            trailing: FloatingActionButton.small(
                              heroTag: DateTime.now().toString(),
                              child: const Icon(Icons.check),
                              backgroundColor: Colors.green,
                              onPressed: () {
                                setState(() {
                                  pledgesList.remove(pledge);
                                  deletePledges(pledge);
                                });
                              },
                            )),
                      );
                    }))
          ]),
        ));
  }
}
