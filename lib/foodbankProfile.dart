import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:http/http.dart';

class DetailedFoodBank extends StatefulWidget {
  final Map data;
  const DetailedFoodBank({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailedFoodBank> createState() => _DetailedFoodBankState();
}

class _DetailedFoodBankState extends State<DetailedFoodBank> {
  int charityID = 0;
  double lat = 0;
  double lng = 0;
  List needsList = [];

  // final needsString = "Unknown";
  //   final needsList = [];
  //   final streetViewLatLng = widget.data["lat_lng"];
  //   final lat = widget.data["lat"];
  //   assert(lat is double);
  //   final lng = widget.data["lng"];
  //   assert(lng is double);

  void fetchNeeds(id) async {
    try {
      final rawData = await get(Uri.parse(
          "https://charity-project-hrmjjb.herokuapp.com/api/${id}/requirements"));
      final encodedData = jsonDecode(rawData.body);
      final output = encodedData["charityRequirements"] as List;
      setState(() {
        needsList = output;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    charityID = widget.data["charity_id"];
    lat = widget.data["lat"];
    lng = widget.data["lng"];
    fetchNeeds(charityID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.data["charity_name"])),
        body: Column(children: [
          Expanded(
              flex: 8,
              child: FlutterGoogleStreetView(
                  initPos: LatLng(lat, lng),
                  initSource: StreetViewSource.outdoor,
                  initBearing: 30,
                  zoomGesturesEnabled: false,
                  onStreetViewCreated:
                      (StreetViewController controller) async {})),
          Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.location_pin),
                        title: Text(widget.data["address"]),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text(widget.data["email_address"]),
                      ),
                    ],
                  ))),
          Expanded(
              flex: 1,
              child: Text("Needs List",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.underline))),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 7,
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                itemCount: needsList.length,
                itemBuilder: (context, i) {
                  final need = needsList[i];
                  print(need);
                  return ListTile(
                    leading: Text(need["category_name"]),
                    title: Text(need["item_id"].toString()),
                    subtitle:
                        Text("amount " + need["quantity_required"].toString()),
                    trailing: ElevatedButton(
                        onPressed: () {}, child: Text("Pledge!")),
                  );
                }),
          )
        ]));
  }
}
