import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';

class DetailedFoodBank extends StatefulWidget {
  final Map data;
  const DetailedFoodBank({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailedFoodBank> createState() => _DetailedFoodBankState();
}

class _DetailedFoodBankState extends State<DetailedFoodBank> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final needsString = widget.data["needs"]["needs"].toString();
    final needsList = needsString.split("\r\n");
    final streetViewLatLng = widget.data["lat_lng"];
    print(widget.data["lat_lng"]);
    final splitted = streetViewLatLng.split(',');
    final lat = double.parse((splitted[0]));
    assert(lat is double);
    final lng = double.parse((splitted[1]));
    assert(lng is double);
    return Scaffold(
        appBar: AppBar(title: Text(widget.data["foodbank"]["name"])),
        body: Column(children: [
          Expanded(
              flex: 2,
              child: FlutterGoogleStreetView(
                  initPos: LatLng(lat, lng),
                  initSource: StreetViewSource.outdoor,
                  initBearing: 30,
                  zoomGesturesEnabled: false,
                  onStreetViewCreated:
                      (StreetViewController controller) async {})),
          Expanded(
              flex: 2,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(widget.data["address"]),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(widget.data["phone"]),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(widget.data["email"]),
                  ),
                ],
              )),
          Expanded(child: Text("Urgent appeals")),
          Expanded(
            child: ListView.builder(
                itemCount: needsList.length,
                itemBuilder: (context, i) {
                  final need = needsList[i];
                  return Text(need);
                }),
          )
        ]));
  }
}
