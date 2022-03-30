import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PledgeForm extends StatelessWidget {
  final Map need;
  final Map data;
  final String? userId;
  final formKey = GlobalKey<FormState>();
  PledgeForm(
      {Key? key, required this.need, required this.data, required this.userId})
      : super(key: key);
  late int pledgeAmount;

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
                height: 200,
                width: 300,
                child: Form(
                    key: formKey,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                    "How many ${need["item_name"]}s would you like to pledge?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 2,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.add_box),
                                    labelText: "Amount",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: ((String? value) {
                                    print(value);
                                    if (value == null || value.length == 0) {
                                      return "Enter the amount";
                                    } else if (int.parse(value) >
                                        need["quantity_required"]) {
                                      return "We only need ${need["quantity_required"]}";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  onSaved: (value) async {
                                    print(need["category_name"]);
                                    final amount = int.parse(value.toString());
                                    final encodedreq = jsonEncode({
                                      "category_name": need["category_name"],
                                      "item_id": need["item_id"],
                                      "quantity_available": amount
                                    });
                                    print(data);
                                    final rawData = await post(
                                        Uri.parse(
                                            "https://charity-project-hrmjjb.herokuapp.com/api/${userId}/donations"),
                                        headers: {
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: encodedreq);
                                    final response = jsonDecode(rawData.body);
                                    print(response);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "${amount} ${need["item_name"]} pledged succsefully")));
                                  },
                                )),
                            Expanded(child: SizedBox()),
                            ElevatedButton(
                              child: Text("Pledge now"),
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();

                                if (isValid) {
                                  formKey.currentState!.save();
                                }
                              },
                            )
                          ],
                        ))))));
  }
}
