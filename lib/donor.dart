import 'dart:convert';
import 'package:flutter/material.dart';
import './foodbankProfile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

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
  var foodBankList = [];
  var url =
      "https://www.givefood.org.uk/api/2/locations/search/?address=West%20One,%20100%20Wellington%20St,%20Leeds%20LS1%204LT";

  void fetchFoodBanks(url) async {
    final rawData = await get(Uri.parse(url));
    final data = jsonDecode(rawData.body) as List;
    setState(() {
      foodBankList = data;
      _markers.clear();
      for (final foodbank in data) {
        final splitted = foodbank["lat_lng"].split(',');
        final lat = double.parse((splitted[0]));
        assert(lat is double);
        final lng = double.parse((splitted[1]));
        assert(lng is double);
        final marker = Marker(
            markerId: MarkerId(foodbank["foodbank"]["name"]),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
                title: foodbank["foodbank"]["name"],
                snippet: foodbank["address"]));
        _markers[foodbank["foodbank"]["name"]] = marker;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFoodBanks(url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("donor")),
            body: Column(
              children: [
                Expanded(
                    child: GoogleMap(
                  initialCameraPosition: Donor._kInitialPosition,
                  mapType: MapType.hybrid,
                  markers: _markers.values.toSet(),
                )),
                SafeArea(
                  child: DropdownButton<String>(
                    value: "One",
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) => {print("changed")},
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: foodBankList.length,
                  itemBuilder: (context, i) {
                    final foodBank = foodBankList[i];
                    return ListTile(
                      onTap: (() => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedFoodBank(data: foodBank)),
                            )
                          }),
                      leading: Icon(Icons.fastfood),
                      title: Text(foodBank["foodbank"]["name"]),
                      trailing: Text(
                          foodBank["distance_m"].toString() + " metres away"),
                      subtitle: Text(foodBank["address"]),
                    );
                  },
                ))
              ],
            )));
  }
}
