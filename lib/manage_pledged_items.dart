import 'package:flutter/material.dart';

class ManagePledges extends StatefulWidget {
  const ManagePledges({Key? key}) : super(key: key);

  @override
  State<ManagePledges> createState() => _ManagePledgesState();
}

class _ManagePledgesState extends State<ManagePledges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage pledged items"),
      ),
    );
  }
}
