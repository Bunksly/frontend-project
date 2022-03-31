import 'package:flutter/material.dart';
import 'package:frontend/karma.dart';
import 'package:frontend/personal_information.dart';
import 'package:frontend/pledged_items.dart';
import 'package:frontend/secure-storage.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String? userId;
  late String? accessToken;
  late List pledges;

  late Map userData = {
    "username": "",
    "address": "",
    "email": "",
  };

  Future startUp() async {
    await init();
    await getUserInfo();
    await Future.delayed(const Duration(seconds: 2), () {});
    await getPledges();
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
    super.initState();
    startUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  CachedNetworkImage(
                    imageUrl: "https://api.multiavatar.com/${userId}.png",
                    height: 100,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    userData['username'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
