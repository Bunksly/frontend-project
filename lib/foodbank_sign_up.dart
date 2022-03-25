import 'package:flutter/material.dart';

class FoodBankSignUp extends StatefulWidget {
  const FoodBankSignUp({Key? key}) : super(key: key);

  @override
  State<FoodBankSignUp> createState() => _FoodBankSignUpState();
}

class _FoodBankSignUpState extends State<FoodBankSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Foodbank Sign Up")),
    );
  }
}
