import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class Donor extends StatefulWidget {
  const Donor({Key? key}) : super(key: key);

  static final LatLng _kMapCenter =
      LatLng(53.426136370592815, -2.242767427254577);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  State<Donor> createState() => _DonorState();
}

class _DonorState extends State<Donor> {
  var foodBankList = [];
  var url =
      "https://www.givefood.org.uk/api/2/locations/search/?address=West%20One,%20100%20Wellington%20St,%20Leeds%20LS1%204LT";

  void fetchFoodBanks(url) async {
    final rawData = await get(Uri.parse(url));
    final data = jsonDecode(rawData.body) as List;
    setState(() {
      foodBankList = data;
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
                  markers: ,
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
