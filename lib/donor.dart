import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Donor extends StatelessWidget {
  const Donor({Key? key}) : super(key: key);

  static final LatLng _kMapCenter =
      LatLng(53.426136370592815, -2.242767427254577);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("donor")),
            body: Column(
              children: [
                Expanded(
                    child: GoogleMap(
                  initialCameraPosition: _kInitialPosition,
                  mapType: MapType.hybrid,
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
                    child: ListView(
                  children: [
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                    ListTile(
                      leading: Text("image here?"),
                      title: Text("charity name"),
                      trailing: Text("distance away"),
                      subtitle: Text("exact addres"),
                    ),
                  ],
                ))
              ],
            )));
  }
}
