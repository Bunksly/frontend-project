import 'dart:developer';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/signup.dart';
import 'package:http/http.dart' as http;

class NewLogin extends StatefulWidget {
  const NewLogin({Key? key}) : super(key: key);

  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final formKey = GlobalKey<FormState>();

  final Map loginData = {"email": null, "password": null};

  bool? valueCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
            height: 350,
            width: 300,
            child: Form(
                key: formKey,
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
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
                                loginData["email"] = value;
                              });
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "E-mail",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Expanded(
                            flex: 4,
                            child: TextFormField(
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
                                  loginData["password"] = value;
                                });
                              },
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: "Password",
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                              child: CheckboxListTile(
                            title: const Text(
                                'Tick here if you have a foodbank account:'),
                            value: valueCheck,
                            onChanged: (bool? value) {
                              setState(() => valueCheck = value);
                            },
                          )),
                        ),
                        Expanded(child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              child: Text('Login'),
                              onPressed: () {
                                final snackBarSucess = SnackBar(
                                    content: Text("Login sucessful!"),
                                    backgroundColor: Color(0xff749C75));
                                final snackBarError = SnackBar(
                                    content:
                                        Text("Login failed, please try again"),
                                    backgroundColor: Color(0xffC17767));
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid && valueCheck!) {
                                  formKey.currentState!.save();
                                  final encodedReq = jsonEncode({
                                    "email_address": loginData["email"],
                                    "password": loginData["password"],
                                  });
                                  foodbankSignIn(loginData) async {
                                    try {
                                      final response = await http.post(
                                          Uri.parse(
                                              'https://charity-project-hrmjjb.herokuapp.com/api/charities/signin'),
                                          headers: {
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: encodedReq);
                                      print(response.body);
                                      if (response.statusCode != 202) {
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarError);
                                      } else
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarSucess);
                                      Navigator.pushNamed(
                                          context, '/food-bank');
                                    } catch (error) {
                                      print(error);
                                    }
                                  }

                                  foodbankSignIn(loginData);
                                }
                              },
                            )),
                        Expanded(child: SizedBox()),
                        Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                          TextSpan(text: 'New to our app?'),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                              style: const TextStyle(
                                  color: Color(0xff749C75),
                                  decoration: TextDecoration.underline),
                              text: ' Sign up now')
                        ]))),
                        Expanded(child: SizedBox()),
                      ],
                    )))),
      ),
      appBar: AppBar(title: Text('Login')),
    );
  }
}
