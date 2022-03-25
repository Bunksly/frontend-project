import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class newLogin extends StatefulWidget {
  const newLogin({Key? key}) : super(key: key);

  @override
  State<newLogin> createState() => _newLoginState();
}

class _newLoginState extends State<newLogin> {
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
            child: Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Expanded(
                            flex: 4,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Expanded(child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Login'))),
                        Expanded(child: SizedBox()),
                        Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                          TextSpan(text: 'New to our app?'),
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style: TextStyle(
                                  color: Color(0xff749C75),
                                  decoration: TextDecoration.underline),
                              text: ' Sign up now')
                        ]))),
                        Expanded(child: SizedBox()),
                      ],
                    )))),
      )),
      appBar: AppBar(title: Text('Login')),
    );
  }
}
