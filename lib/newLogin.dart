import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/signup.dart';

class newLogin extends StatefulWidget {
  const newLogin({Key? key}) : super(key: key);

  @override
  State<newLogin> createState() => _newLoginState();
}

class _newLoginState extends State<newLogin> {
  final formKey = GlobalKey<FormState>();

  final Map loginData = {"email": null, "password": null};

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
            height: 300,
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
                        Expanded(child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                                onPressed: () {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    formKey.currentState!.save();
                                    print(loginData);
                                  }
                                },
                                child: Text('Login'))),
                        Expanded(child: SizedBox()),
                        Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                          TextSpan(text: 'New to our app?'),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
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
