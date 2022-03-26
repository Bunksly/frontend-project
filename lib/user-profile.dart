import 'package:flutter/material.dart';
import 'package:frontend/personal_information.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Map userData = {
    'name': 'Notorious P.I.N.G.U',
    'image':
        'https://images.unsplash.com/photo-1598439119086-35655b8c333d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
    'address': 'Industrial freezer, Manningham, Bradford',
    'number': 07898898898,
    'email': 'test@testmail.co.uk'
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
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
                    backgroundImage: NetworkImage(userData['image']),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    userData['name'],
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
                          onTap: () => print("Chickens"))),
                  Card(
                      child: ListTile(
                          leading: Icon(Icons.favorite_border),
                          title: Text('Karma'),
                          onTap: () => print("Chickens"))),
                ],
              ))
            ]),
          ),
        ));
  }
}
