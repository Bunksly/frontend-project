import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  final Map data;
  PersonalInfo({Key? key, required this.data}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Personal Information")),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
                child: Container(
                    padding: EdgeInsets.all(15),
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ]),
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        Expanded(
                            child: Text(
                          "Account Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                        Expanded(
                            flex: 2,
                            child: ListTile(
                                leading: Icon(Icons.account_box),
                                title: Text(data["username"]))),
                        Expanded(
                            flex: 2,
                            child: ListTile(
                                leading: Icon(Icons.email),
                                title: Text(data["email"]))),
                        Expanded(
                            flex: 2,
                            child: ListTile(
                                leading: Icon(Icons.lock),
                                title: Text("****"))),
                        Expanded(
                            flex: 2,
                            child: ListTile(
                                leading: Icon(Icons.house),
                                title: Text(data["address"]))),
                        // Expanded(
                        //     flex: 2,
                        //     child: ListTile(
                        //         leading: Icon(Icons.phone),
                        //         title: Text(data["number"]))),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  print("insert useful functionality here");
                                },
                                child: Text("Modify")))
                      ]),
                    )))));
  }
}
