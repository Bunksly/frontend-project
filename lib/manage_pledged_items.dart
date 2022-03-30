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
      print(pledgesList);
    });
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
      body: ListView.builder(
          itemCount: pledgesList.length,
          itemBuilder: (BuildContext context, i) {
            final pledge = pledgesList[i];
            return Card(
              child: ListTile(
                leading: Text(pledge["username"]),
                title: Text(pledge["item_name"]),
                subtitle: Text(pledge["category_name"]),
                trailing: Text(pledge["quantity_available"]),
              ),
            );
          }),
    );
  }
}
