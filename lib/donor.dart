import 'package:flutter/material.dart';

class Donor extends StatelessWidget {
  const Donor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("donor")),
            body: Column(
              children: [
                Expanded(child: Text("hello?")),
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
