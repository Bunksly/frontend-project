import 'package:flutter/material.dart';
import 'package:frontend/donor_sign_up.dart';
import 'package:frontend/foodbank_sign_up.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 75),
            CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/donorimage.jpg")),
            const SizedBox(height: 10),
            Container(
                width: 300,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DonorSignUp()));
                  },
                  child: Row(children: const [
                    Expanded(child: Icon(Icons.account_box_rounded)),
                    Expanded(
                        flex: 5,
                        child: Center(
                            child: Text(
                          "I am a donor",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )))
                  ]),
                )),
            const SizedBox(height: 75),
            CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/foodbankimage.jpg")),
            const SizedBox(height: 10),
            Container(
              width: 300,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodBankSignUp()));
                },
                child: Row(children: const [
                  Expanded(child: Icon(Icons.account_balance_rounded)),
                  Expanded(
                      flex: 5,
                      child: Center(
                          child: Text(
                        "I am a Foodbank or Charity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )))
                ]),
              ),
            )
          ],
        )),
      ),
    );
  }
}
