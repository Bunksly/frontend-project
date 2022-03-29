import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import './foodbankProfile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  late GoogleMapController _googleMapController;
  final Map<String, Marker> _markers = {};
  late Marker currentPosMarker;
  late double userlat;
  late double userlng;
  int dropdownValue = 5000;
  late int range;
  List foodBankList = [];
  late String url;
  bool isSearching = false;

  void fetchFoodBanks(url) async {
    try {
      final rawData = await get(Uri.parse(url));
      final data = jsonDecode(rawData.body);
      final output = data["charities"] as List;
      _markers.clear();
      currentPosMarker = Marker(
          markerId: MarkerId("current_position" + DateTime.now().toString()),
          infoWindow: InfoWindow(title: 'Current Position'),
          position: LatLng(userlat, userlng),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
      _markers["current_position" + DateTime.now().toString()] =
          currentPosMarker;
      for (final foodbank in output) {
        final lat = foodbank["lat"];
        final lng = foodbank["lng"];
        final marker = Marker(
            markerId: MarkerId(foodbank["charity_name"]),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
                title: foodbank["charity_name"], snippet: foodbank["address"]));
        _markers[foodbank["charity_name"]] = marker;
      }
      setState(() {
        foodBankList = output;
      });
    } catch (err) {
      print(err);
    }
  }

  getLatLng(value) async {
    final geoUrl =
        value.replaceAll(RegExp(r'([,\s]\s*)'), "%20") + "%20United%20Kingdom";
    try {
      final response = await get(Uri.parse(
          "https://api.myptv.com/geocoding/v1/locations/by-text?searchText=${geoUrl}&apiKey=${env["PTVKEY"]}"));
      final data = jsonDecode(response.body);
      setState(() {
        userlat = data["locations"][0]["referencePosition"]["latitude"];
        userlng = data["locations"][0]["referencePosition"]["longitude"];
        _googleMapController
            .animateCamera(CameraUpdate.newLatLng(LatLng(userlat, userlng)));
        url =
            "https://charity-project-hrmjjb.herokuapp.com/api/charities?lat=${userlat}&lng=${userlng}&range=${range}";
        fetchFoodBanks(url);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    userlat = 53.80754277823678;
    userlng = -1.5484416213022532;
    range = 5000;
    url =
        "https://charity-project-hrmjjb.herokuapp.com/api/charities?lat=${userlat}&lng=${userlng}&range=${range}";
    fetchFoodBanks(url);
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
              mapType: MapType.normal,
              markers: _markers.values.toSet(),
              myLocationEnabled: false,
              onMapCreated: (controller) {
                _googleMapController = controller;
              },
            )),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(children: [
                  Expanded(
                      child: DropdownSearch<int>(
                          mode: Mode.MENU,
                          items: [500, 1000, 2500, 5000],
                          selectedItem: dropdownValue,
                          label: "Search range(m)",
                          showSearchBox: false,
                          validator: (value) {
                            if (value == null) return "Select Range";
                            return null;
                          },
                          onChanged: (int? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              range = newValue;
                              url =
                                  "https://charity-project-hrmjjb.herokuapp.com/api/charities?lat=${userlat}&lng=${userlng}&range=${range}";
                              fetchFoodBanks(url);
                            });
                          })),
                  Expanded(
                      child: TextFormField(
                    onFieldSubmitted: (String value) {
                      getLatLng(value);
                    },
                    decoration: InputDecoration(
                        labelText: "Search by address",
                        border: OutlineInputBorder()),
                  )),
                ])),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      itemCount: foodBankList.length,
                      itemBuilder: (context, i) {
                        final foodBank = foodBankList[i];
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
