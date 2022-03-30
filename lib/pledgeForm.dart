import 'package:flutter/material.dart';

class PledgeForm extends StatelessWidget {
  final Map need;
  final formKey = GlobalKey<FormState>();
  PledgeForm({Key? key, required this.need}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pledge form")),
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
                height: 250,
                width: 300,
                child: Form(
                    key: formKey,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Expanded(child: SizedBox()),
                            Expanded(
                                child: Text(
                                    "How many ${need["item_name"]}s would you like to pledge?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                child: TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.add_box),
                                labelText: "Amount",
                                border: OutlineInputBorder(),
                              ),
                              validator: ((String? value) {
                                if (value == null) {
                                  return "Enter the amount";
                                } else if (int.parse(value) >
                                    need["quantity_required"]) {
                                  return "We only need ${need["quantity_required"]}";
                                } else {
                                  return null;
                                }
                              }),
                            )),
                            Expanded(
                                child: ElevatedButton(
                              child: Text("Pledge now"),
                              onPressed: () {},
                            ))
                          ],
                        ))))));
  }
}
