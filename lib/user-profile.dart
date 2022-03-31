import 'package:flutter/material.dart';
import 'package:frontend/karma.dart';
import 'package:frontend/loading.dart';
import 'package:frontend/personal_information.dart';
import 'package:frontend/pledged_items.dart';
import 'package:frontend/secure-storage.dart';
import 'dart:convert';
import 'package:http/http.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String? userId;
  late String? accessToken;
  late List pledges;
  bool isLoading = true;

  late Map userData = {
    "username": "",
    "address": "",
    "email": "",
  };

  Future startUp() async {
    await init();
    await getUserInfo();
    await Future.delayed(const Duration(seconds: 1), () {});
    await getPledges();
    setState(() {
      isLoading = false;
    });
  }

  Future init() async {
    final getToken = await UserSecureStorage.getAccessToken();
    final getId = await UserSecureStorage.getUserId();
    setState(() {
      userId = getId;
      accessToken = getToken;
    });
  }

  Future getUserInfo() async {
    final rawData = await get(
        Uri.parse(
            "https://charity-project-hrmjjb.herokuapp.com/api/donors/${userId}"),
        headers: {
          "x-access-token": accessToken.toString(),
        });
    final data = jsonDecode(rawData.body);
    print(data);
    setState(() {
      userData["username"] = data["donor"]["username"];
      userData["address"] = data["donor"]["address"];
      userData["email"] = data["donor"]["email_address"];
    });
  }

  Future getPledges() async {
    final rawData = await get(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/${userId}/donations"));
    final data = jsonDecode(rawData.body);
    final pledgedata = data["donatorDonations"] as List;
    setState(() {
      pledges = pledgedata;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startUp();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (() => Navigator.pushNamed(context, '/donor'))),
            ),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Column(children: [
                  Expanded(
                      child: Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "https://gravatar.com/avatar/67fbbf18af4bdbbbc55f1900b9698cce?s=200&d=robohash&r=x"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        userData['username'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(userData['address']),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Card(
                          child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Personal Information'),
                              onTap: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalInfo(data: userData)),
                                    )
                                  })),
                      Card(
                          child: ListTile(
                              leading: Icon(Icons.check_circle_outline),
                              title: Text('Pledged Items'),
                              onTap: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PledgedItems(data: pledges)),
                                    )
                                  })),
                      Card(
                          child: ListTile(
                              leading: Icon(Icons.favorite_border),
                              title: Text('Karma'),
                              onTap: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Karma(data: userData)),
                                    )
                                  })),
                    ],
                  ))
                ]),
              ),
            ));
  }
}
