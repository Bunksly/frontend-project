import 'package:flutter/material.dart';
import 'package:frontend/foodbank.dart';
import 'package:frontend/request_page.dart';
import 'package:frontend/widget/appbar_widget.dart';
import 'package:frontend/foodbank_data.dart';
import 'package:frontend/widget/profile_widgets.dart';
import 'package:frontend/widget/button_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map> needList = [{
"itemName": "pasta",
"Amount":50,
"isUrgent": true
}];

  @override
  Widget build(BuildContext context) {
    final foodbank = FoodbankData.myFoodbank;

    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(children: [
          Expanded(flex:2, child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: foodbank.imagePath,
                onClicked: () async {},
              ),
              const SizedBox(height: 50),
              buildName(foodbank),
              Center(child: buildItemsButton()),
            ],
          ),
          ),
          Expanded(child: ListView.builder(
            itemCount: needList.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(needList[i]["itemName"]),

              );
            }))
        ]));
  }

// foodbank name address and button to next page
  Widget buildName(Foodbank foodbank) => Column(
        children: [
          Text(foodbank.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 50),
          Text(
            foodbank.address,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

//button to the required items page
  Widget buildItemsButton() => ButtonWidget(
        text: "Request Items",
        onClicked: () {
          // function to link to the next page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestPage(),
              ));
        }, // function to link to the next page
      );
}
