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
              /*backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')*/
            ),
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
              /*backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/6590920/pexels-photo-6590920.jpeg?cs=srgb&dl=pexels-cottonbro-6590920.jpg&fm=jpg')*/
            ),
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
