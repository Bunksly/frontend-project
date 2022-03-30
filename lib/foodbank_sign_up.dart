import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/profile_page.dart';
import 'package:http/http.dart' as http;

class FoodBankSignUp extends StatefulWidget {
  const FoodBankSignUp({Key? key}) : super(key: key);

  @override
  State<FoodBankSignUp> createState() => _FoodBankSignUpState();
}

class _FoodBankSignUpState extends State<FoodBankSignUp> {
  final formKey = GlobalKey<FormState>();

  Map signupData = {
    "name": null,
    "email": null,
    "password": null,
    "address": null,
    "number": null,
    "website": null
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Foodbank Sign Up")),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(15),
                  width: 300,
                  height: 550,
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
                                labelText: "Charity Name",
                                border: OutlineInputBorder()),
                            validator: (String? value) {
                              ;
                              if (value == null || value.length == 0) {
                                return "Enter name";
                              } else if (value.length < 2) {
                                return "Enter valid name";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                signupData["name"] = value;
                              });
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: " Charity E-mail",
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
                            onSaved: (value) {
                              setState(() {
                                signupData["email"] = value;
                              });
                            },
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
                            onSaved: (value) {
                              setState(() {
                                signupData["password"] = value;
                              });
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.house),
                                labelText: "Charity Address",
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
                            onSaved: (value) {
                              setState(() {
                                signupData["address"] = value;
                              });
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.phone),
                                labelText: "Charity Mobile Number",
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
                            onSaved: (value) {
                              setState(() {
                                signupData["number"] = value;
                              });
                            },
                          )),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.mouse),
                                labelText: "Charity Website",
                                border: OutlineInputBorder()),
                            validator: (String? value) {
                              const pattern =
                                  r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';
                              final regexp = RegExp(pattern);
                              if (value == null || value.length == 0) {
                                return "Enter a url";
                              } else if (!regexp.hasMatch(value)) {
                                return "Enter valid url";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                signupData["website"] = value;
                              });
                            },
                          )),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                final snackBarSucess = SnackBar(
                                    content: Text("Signup sucessful!"),
                                    backgroundColor: Color(0xff749C75));
                                final snackBarError = SnackBar(
                                    content:
                                        Text("Signup error, please try again"),
                                    backgroundColor: Color(0xffC17767));
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  formKey.currentState!.save();
                                  final encodedReq = jsonEncode({
                                    "email_address": signupData["email"],
                                    "password": signupData["password"],
                                    "charity_name": signupData["name"],
                                    "address": signupData["address"],
                                    "charity_website": signupData["website"]
                                  });
                                  foodbankSignup(signupData) async {
                                    try {
                                      final response = await http.post(
                                          Uri.parse(
                                              'https://charity-project-hrmjjb.herokuapp.com/api/charities'),
                                          headers: {
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: encodedReq);
                                      print(response.body);
                                      if (response.statusCode != 201) {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarError);
                                      } else
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarSucess);
                                      Navigator.pushNamed(context, '/login');
                                    } catch (error) {
                                      print(error);
                                    }
                                  }

                                  foodbankSignup(signupData);
                                }
                              },
                              child: Text("Submit")))
                    ]),
                  )),
            )));
  }
}
