import 'package:flutter/material.dart';

class DonorSignUp extends StatefulWidget {
  const DonorSignUp({Key? key}) : super(key: key);

  @override
  State<DonorSignUp> createState() => _DonorSignUpState();
}

class _DonorSignUpState extends State<DonorSignUp> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Donor Sign Up")),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(15),
                  width: 300,
                  height: 500,
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
                        "Fill in account details for registration",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.account_box),
                                labelText: "Name",
                                border: OutlineInputBorder()),
                            validator: (String? value) {
                              const pattern = r'(^[a-zA-Z]+$)';
                              final regexp = RegExp(pattern);
                              if (value == null || value.length == 0) {
                                return "Enter name";
                              } else if (!regexp.hasMatch(value)) {
                                return "Enter valid name";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: "E-mail",
                                border: OutlineInputBorder()),
                            validator: ((String? value) {
                              const pattern = r'(^[^\s@]+@[^\s@]+\.[^\s@]+$)';
                              final regExp = RegExp(pattern);
                              if (value == null || value.length == 0) {
                                return "Enter an email";
                              } else if (!regExp.hasMatch(value)) {
                                return "Enter valid email";
                              } else {
                                return null;
                              }
                            }),
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: "Password",
                                border: OutlineInputBorder()),
                            obscureText: true,
                            validator: ((String? value) {
                              if (value == null || value.length == 0) {
                                return "Enter a password";
                              } else if (value.length < 5) {
                                return "Enter valid password";
                              } else {
                                return null;
                              }
                            }),
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.house),
                                labelText: "Address",
                                border: OutlineInputBorder()),
                            validator: (String? value) {
                              if (value == null || value.length == 0) {
                                return "Enter an address";
                              } else if (value.length < 10) {
                                return "Enter valid address";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.phone),
                                labelText: "Mobile Number",
                                border: OutlineInputBorder()),
                            validator: (String? value) {
                              const pattern =
                                  r'(^(07[\d]{8,12}|447[\d]{7,11})$)';
                              final regexp = RegExp(pattern);
                              if (value == null || value.length == 0) {
                                return "Enter a number";
                              } else if (value.length != 11) {
                                return "Enter valid number";
                              } else if (!regexp.hasMatch(value)) {
                                return "Enter valid number";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();
                              },
                              child: Text("Submit")))
                    ]),
                  )),
            )));
  }
}
