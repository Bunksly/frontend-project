import 'package:flutter/material.dart';
import 'package:frontend/request_page.dart';
import 'package:frontend/secure-storage.dart';

class FoodBankPage extends StatefulWidget {
  const FoodBankPage({Key? key}) : super(key: key);

  @override
  State<FoodBankPage> createState() => _FoodBankPageState();
}

class _FoodBankPageState extends State<FoodBankPage> {
  late String? userId;
  late String? accessToken;
  List<Map> needList = [
    {
      "itemName": "pasta",
      "quantityRequired": 50,
      "categoryName": "food",
      "isUrgent": true
    }
  ];

  final Map charity = {
    "charity_id": 1,
    "charity_name": "Charity 1d",
    "charity_image":
        "https://leedsnorthandwest.foodbank.org.uk/wp-content/uploads/sites/124/2016/04/Leeds-North-and-West-Three-Colour-logo.png",
    "address": "1 charity road,\n location1,\n A666AA",
    "charity_website": "testcharitywebsite1d",
    "email_address": "testEmail1d"
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
    init();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(charity["charity_name"])),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Expanded(
                flex: 6,
                child: Column(children: [
                  Image.network(
                    charity["charity_image"],
                    height: 100,
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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestPage(
                                    list: needList, statefn: setParentState)));
                      },
                      child: Text("Request Items")),
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
                        return Card(
                            child: ListTile(
                          leading: urgentIcon(needList[i]["isUrgent"]),
                          title: Text(needList[i]["itemName"] +
                              "(${needList[i]["quantityRequired"].toString()})"),
                          trailing: Text(needList[i]["categoryName"]),
                          //  trailing:
                        ));
                      }))
            ])));
  }
}
