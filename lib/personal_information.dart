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
                child: Form(
              key: formKey,
              child: Column(children: [
                TextField(),
                TextField(),
                TextField(),
                TextField(),
                TextField(),
              ]),
            ))));
  }
}
