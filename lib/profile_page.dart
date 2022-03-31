import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/loading.dart';
import 'package:frontend/request_page.dart';
import 'package:frontend/secure-storage.dart';
import 'package:frontend/manage_pledged_items.dart';
import 'package:http/http.dart';

class FoodBankPage extends StatefulWidget {
  const FoodBankPage({Key? key}) : super(key: key);

  @override
  State<FoodBankPage> createState() => _FoodBankPageState();
}

class _FoodBankPageState extends State<FoodBankPage> {
  late String? userId;
  late String? accessToken;
  List needList = [];
  bool isLoading = true;

  Map charity = {
    "charity_name": "",
    "address": "",
    "charity_website": "",
    "email_address": ""
  };

  Icon urgentIcon(input) {
    if (input) {
      return Icon(Icons.check);
    } else {
      return Icon(Icons.close);
    }
  }

  void setParentState(input) {
    setState(() {
      needList = input;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startUp();
  }

  Future init() async {
    final getToken = await UserSecureStorage.getAccessToken();
    final getId = await UserSecureStorage.getUserId();
    setState(() {
      userId = getId;
      accessToken = getToken;
      print(userId);
      print(accessToken);
    });
  }

  Future startUp() async {
    await init();
    await getFoodbank();
    //await Future.delayed(const Duration(seconds: 2), () {});
    await getRequirements();
    setState(() {
      isLoading = false;
    });
  }

  Future getFoodbank() async {
    final rawData = await get(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/charities/${userId}"));
    final data = jsonDecode(rawData.body);
    setState(() {
      charity["charity_name"] = data["charity"]["charity_name"];
      charity["address"] = data["charity"]["address"];
      charity["charity_website"] = data["charity"]["charity_website"];
      charity["email_address"] = data["charity"]["email_address"];
    });
  }

  Future getRequirements() async {
    final rawData = await get(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/${userId}/requirements"));
    final data = jsonDecode(rawData.body);
    setState(() {
      needList = data["charityRequirements"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(charity["charity_name"]),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Padding(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Expanded(
                    flex: 6,
                    child: Column(children: [
                      CachedNetworkImage(
                        imageUrl: "https://api.multiavatar.com/${userId}.png",
                        height: 100,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text(charity["charity_name"])),
                      ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text(charity["address"])),
                      ListTile(
                          leading: Icon(Icons.email),
                          title: Text(charity["email_address"])),
                      ListTile(
                          leading: Icon(Icons.web_rounded),
                          title: Text(charity["charity_website"])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RequestPage(
                                            list: needList,
                                            statefn: setParentState,
                                            userId: userId)));
                              },
                              child: Text("Request Items")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManagePledges(userId: userId)));
                              },
                              child: Text("Items pledged"))
                        ],
                      ),
                    ]),
                  ),
                  Row(
                    children: const [
                      Expanded(
                          flex: 1,
                          child: Text("Urgent?",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 4,
                          child: Text("Item Name(Amount needed)",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("category",
                              style: TextStyle(fontWeight: FontWeight.bold)))
                    ],
                  ),
                  Expanded(
                      flex: 3,
                      child: ListView.builder(
                          itemCount: needList.length,
                          itemBuilder: (context, i) {
                            print(needList[i]);
                            return Card(
                                child: ListTile(
                              leading: urgentIcon(needList[i]["urgent"]),
                              title: Text(needList[i]["item_name"] +
                                  "(${needList[i]["quantity_required"].toString()})"),
                              trailing: Text(needList[i]["category_name"]),
                              //  trailing:
                            ));
                          }))
                ])));
  }
}
