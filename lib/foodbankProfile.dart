import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:http/http.dart';
import 'package:frontend/pledgeForm.dart';

class DetailedFoodBank extends StatefulWidget {
  final Map data;
  final String? userId;
  const DetailedFoodBank({Key? key, required this.data, required this.userId})
      : super(key: key);

  @override
  State<DetailedFoodBank> createState() => _DetailedFoodBankState();
}

class _DetailedFoodBankState extends State<DetailedFoodBank> {
  int charityID = 0;
  double lat = 0;
  double lng = 0;
  List needsList = [];
  List donationsList = [];

  // final needsString = "Unknown";
  //   final needsList = [];
  //   final streetViewLatLng = widget.data["lat_lng"];
  //   final lat = widget.data["lat"];
  //   assert(lat is double);
  //   final lng = widget.data["lng"];
  //   assert(lng is double);

  Future fetchNeeds() async {
    try {
      final rawData = await get(Uri.parse(
          "https://charity-project-hrmjjb.herokuapp.com/api/${widget.data["charity_id"]}/requirements"));
      final encodedData = jsonDecode(rawData.body);
      final output = encodedData["charityRequirements"] as List;
      setState(() {
        needsList = output;
      });
    } catch (err) {
      print(err);
    }
  }

  Future fetchPledges() async {
    final rawData = await get(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/${widget.userId}/donations"));
    final data = jsonDecode(rawData.body);
    final output = data["donatorDonations"] as List;
    setState(() {
      donationsList = output;
    });
  }

  void startUp() async {
    await fetchNeeds();
    await fetchPledges();
    setState(() {
      for (final x in needsList) {
        for (final y in donationsList) {
          print(x);
          print(y);
          if (y["charity_id"] == x["charity_id"] &&
              y["item_id"] == x["item_id"] &&
              y["urgent"] == x["urgent"]) {
            x["quantity_required"] -= y["quantity_available"];
          }
        }
      }
    });
  }

  String isUrgent(need) {
    if (need["urgent"]) return "Urgent!";
    return "";
  }

  @override
  void initState() {
    super.initState();
    lat = widget.data["lat"];
    lng = widget.data["lng"];
    startUp();
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
                  return ListTile(
                    leading: Text(need["category_name"]),
                    title: Center(
                      child: Text(need["item_name"]),
                    ),
                    subtitle: Center(
                      child: Text("amount " +
                          need["quantity_required"].toString() +
                          " " +
                          isUrgent(need)),
                    ),
                    trailing: ElevatedButton(
                        onPressed: () {
                          if (need["quantity_required"] == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Color(0xff457B9D),
                                content: Text("Maximum amount already pledged",
                                    style: TextStyle(color: Colors.white))));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PledgeForm(
                                        need: need,
                                        data: widget.data,
                                        userId: widget.userId)));
                          }
                        },
                        child: Text("Pledge!")),
                  );
                }),
          )
        ]));
  }
}
