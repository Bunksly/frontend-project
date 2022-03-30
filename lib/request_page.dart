import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:convert';
import 'package:http/http.dart';

class RequestPage extends StatelessWidget {
  static final String title = "Item Request Page";
  final List list;
  final Function statefn;
  final String? userId;
  const RequestPage(
      {Key? key,
      required this.list,
      required this.statefn,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title),
      ),
      body: MainPage(
        list: list,
        statefn: statefn,
        userId: userId,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final List list;
  final Function statefn;
  final String? userId;
  const MainPage(
      {Key? key,
      required this.list,
      required this.statefn,
      required this.userId});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();

  String? dropdownValue = null;

  List<String>? categoryList = [];

  List categoryInfo = [];

  List<String>? itemList = [];

  List itemInfo = [];

  String? itemName = null;
  int? quantityRequired = 0;
  String? categoryName = '';
  bool? isUrgent = false;
  late int? itemId;

  void deleteRequirement(id) async {
    final rawData = await delete(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/requirements/${id}"));
    print(rawData.statusCode);
  }

  void postRequirement(requestBody) async {
    final encodedReq = jsonEncode(requestBody);
    final rawData = await post(
        Uri.parse(
            "https://charity-project-hrmjjb.herokuapp.com/api/${widget.userId}/requirements"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: encodedReq);
  }

  void patchRequirement(patchBody) async {
    final encodedReq = jsonEncode(patchBody);
    final rawData = await patch(
        Uri.parse(
            "https://charity-project-hrmjjb.herokuapp.com/api/${widget.userId}/requirements"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: encodedReq);
    print(rawData.body);
  }

  Icon urgentIcon(input) {
    if (input) {
      return const Icon(Icons.check);
    } else {
      return const Icon(Icons.close);
    }
  }

  void getCategories() async {
    final rawData = await get(Uri.parse(
        "https://charity-project-hrmjjb.herokuapp.com/api/categories"));
    final data = jsonDecode(rawData.body);
    final output = data["categories"] as List;
    final mappedOutput = output.map(
      (e) {
        return e["category_name"];
      },
    ).toList();
    setState(() {
      categoryInfo = output;
      categoryList = mappedOutput.cast<String>();
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Expanded(
            flex: 4,
            child: Form(
              key: formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: buildCategory(),
                  ),
                  Expanded(
                    child: buildItemName(),
                  ),
                  Expanded(
                    child: buildQuantityRequired(),
                  ),
                  Expanded(
                    child: buildIsUrgent(),
                  ),
                  buildSubmit(),
                ],
              ),
            )),
        Expanded(
          flex: 1,
          child: Row(
            children: const [
              Expanded(
                  flex: 3,
                  child: Text("Urgent?",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 12,
                  child: Text("Item Name(Amount needed)",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 3,
                  child: Text("Delete",
                      style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, i) {
                return Card(
                    child: ListTile(
                        leading: urgentIcon(widget.list[i]["urgent"]),
                        title: Text(widget.list[i]["item_name"] +
                            "(${widget.list[i]["quantity_required"].toString()})"),
                        subtitle: Text(
                            "Category: " + widget.list[i]["category_name"]),
                        trailing: SizedBox(
                          height: 25,
                          child: FloatingActionButton.small(
                              heroTag: DateTime.now().toString(),
                              child: const Icon(Icons.clear),
                              backgroundColor: Colors.red,
                              onPressed: () {
                                print(widget.list[i]["request_id"]);
                                // deleteRequirement(widget.list[i]["request_id"]);
                                setState(() {
                                  widget.list.removeWhere((e) =>
                                      e["item_name"] ==
                                          widget.list[i]["item_name"] &&
                                      e["urgent"] == widget.list[i]["urgent"]);
                                  widget.statefn(widget.list);
                                });
                              }),
                        )));
              }),
        )
      ]));

  Widget buildCategory() => DropdownSearch<String>(
      mode: Mode.MENU,
      items: categoryList,
      selectedItem: dropdownValue,
      label: "Select Category",
      showSearchBox: false,
      popupItemDisabled: (String s) => s.startsWith('I'),
      validator: (value) {
        if (value == null) return "Select Category";
        return null;
      },
      onChanged: (String? newValue) async {
        final info = categoryInfo
            .where((e) => e["category_name"] == newValue)
            .toList()[0];
        final rawData = await get(Uri.parse(
            "https://charity-project-hrmjjb.herokuapp.com/api/items/${info["category_id"]}"));
        final data = jsonDecode(rawData.body);
        final output = data["items"] as List;
        final mappedOutput =
            output.map((e) => e["item_name"].toString()).toList();
        setState(() {
          itemInfo = output;
          itemList = mappedOutput;
          dropdownValue = newValue!;
          categoryName = newValue;
          itemName = null;
        });
      });

  Widget buildItemName() => DropdownSearch<String>(
      mode: Mode.MENU,
      items: itemList,
      selectedItem: itemName,
      label: "Select Item",
      showSearchBox: true,
      popupItemDisabled: (String s) => s.startsWith('I'),
      validator: (value) {
        if (value == null) return "Select Item";
        return null;
      },
      onChanged: (String? newValue) {
        final info =
            itemInfo.where((e) => e["item_name"] == newValue).toList()[0];

        setState(() {
          itemName = newValue;
          itemId = info["item_id"];
        });
      });

  Widget buildQuantityRequired() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Quantity required',
          border: OutlineInputBorder(),
        ),
        validator: (String? value) {
          const pattern = r'(^[0-9]*$)';
          final regExp = RegExp(pattern);
          if (value == null) return 'Enter an amount';
          if (value.length == 0) {
            return 'Enter an amount';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid amount';
          } else {
            return null;
          }
        },
        maxLength: 3,
        // keyboardType: TextInputType.emailAddress,
        onSaved: (value) =>
            setState(() => quantityRequired = int.parse(value.toString())),
      );

  Widget buildIsUrgent() => CheckboxListTile(
      dense: false,
      value: isUrgent,
      title: Text("Urgent?"),
      onChanged: (bool? newValue) {
        setState(() {
          isUrgent = newValue;
        });
      });

  Widget buildSubmit() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            final isValid = formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              Map output = {
                "item_name": itemName,
                "quantity_required": quantityRequired,
                "category_name": categoryName,
                "urgent": isUrgent,
                "item_id": itemId
              };

              Map requestBody = {
                "category_name": categoryName,
                "item_id": itemId,
                "quantity_required": quantityRequired
              };

              void duplicateAdder() {
                bool didAdd = false;
                for (final x in widget.list) {
                  String outputItemName = output["item_name"];
                  String xItemName = x["item_name"];
                  if (xItemName == outputItemName &&
                      x["urgent"] == output["urgent"]) {
                    x["quantity_required"] += output["quantity_required"];
                    didAdd = true;
                    Map patchBody = {
                      "request_id": x["request_id"],
                      "quantity_required": quantityRequired
                    };
                    patchRequirement(patchBody);
                    break;
                  }
                }
                if (didAdd == false) {
                  widget.list.add(output);

                  postRequirement(requestBody);
                }
              }

              duplicateAdder();

              widget.statefn(widget.list);
            }
          },
        ),
      );
}
