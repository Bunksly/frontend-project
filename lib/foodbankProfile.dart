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
    final needsString = "Unknown";
    final needsList = [];
    final streetViewLatLng = widget.data["lat_lng"];
    print(widget.data["lat_lng"]);
    final lat = widget.data["lat"];
    assert(lat is double);
    final lng = widget.data["lng"];
    assert(lng is double);
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
              flex: 9,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.location_pin),
                        title: Text(widget.data["address"]),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("number?"),
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
                    leading: Icon(Icons.food_bank),
                    title: Text(need),
                    subtitle: Text("amount needed"),
                    trailing: ElevatedButton(
                        onPressed: () {}, child: Text("Pledge!")),
                  );
                }),
          )
        ]));
  }
}
