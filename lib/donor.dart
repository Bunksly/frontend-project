import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import './foodbankProfile.dart';

class Donor extends StatefulWidget {
  const Donor({Key? key}) : super(key: key);

  static final LatLng _kMapCenter =
      LatLng(53.80754277823678, -1.5484416213022532);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  State<Donor> createState() => _DonorState();
}

class _DonorState extends State<Donor> {
  final Map<String, Marker> _markers = {};
  double userlat = 0;
  double userlng = 0;
  var foodBankList = [];
  var url = "https://charity-project-hrmjjb.herokuapp.com/api/charities";
  bool isSearching = false;

  void fetchFoodBanks(url) async {
    try {
      final rawData = await get(Uri.parse(url));
      final data = jsonDecode(rawData.body);
      final output = data["charities"] as List;
      print(output);
      setState(() {
        foodBankList = output;
        _markers.clear();
        for (final foodbank in output) {
          final lat = foodbank["lat"];
          final lng = foodbank["lng"];
          final marker = Marker(
              markerId: MarkerId(foodbank["charity_name"]),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                  title: foodbank["charity_name"],
                  snippet: foodbank["address"]));
          _markers[foodbank["charity_name"]] = marker;
        }
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodBanks(url);
    userlat = 53.80754277823678;
    userlng = -1.5484416213022532;
    url =
        "https://charity-project-hrmjjb.herokuapp.com/api/charities?lat=${userlat}&lng=${userlng}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Local Foodbanks"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: Icon(Icons.account_box))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: GoogleMap(
              initialCameraPosition: Donor._kInitialPosition,
              mapType: MapType.hybrid,
              markers: _markers.values.toSet(),
            )),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Row(children: [
                  Expanded(child: DropdownSearch()),
                  Expanded(child: DropdownSearch()),
                ])),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      itemCount: foodBankList.length,
                      itemBuilder: (context, i) {
                        final foodBank = foodBankList[i];
                        print(foodBank);
                        return Card(
                            child: ListTile(
                          onTap: (() => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailedFoodBank(data: foodBank)),
                                )
                              }),
                          leading: Icon(Icons.food_bank),
                          title: Text(foodBank["charity_name"]),
                          trailing: Text(foodBank["distance"].toString() + "m"),
                          subtitle: Text(foodBank["address"]),
                        ));
                      },
                    )))
          ],
        ));
  }
}
