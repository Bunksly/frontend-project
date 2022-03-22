import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({ 
    Key? key,
    required this.text,
    required this.onClicked,
     }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.green.shade400,
      shape: StadiumBorder(),
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
    onPressed: onClicked, 
    child: Text(text)
    );
}