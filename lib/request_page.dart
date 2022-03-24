import 'package:flutter/material.dart';
import 'package:frontend/widget/button_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RequestPage extends StatelessWidget {
  static final String title = "request page";
  final List<Map> list;
  final Function statefn;
  const RequestPage({Key? key, required this.list, required this.statefn})
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
      body: MainPage(list: list, statefn: statefn),
    );
  }
}

class MainPage extends StatefulWidget {
  final List<Map> list;
  final Function statefn;
  const MainPage({Key? key, required this.list, required this.statefn});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();

  String dropdownValue = 'food';

  final categoryList = ["food", "clothes", "toiletries"];

  final Map itemMap = {
    "food": ["pasta", "bread", "bananas"],
    "clothes": ["trousers", "shirts", "shoes"],
    "toiletries": ["soap", "toothpaste", "toilet paper"]
  };

  String? itemName = null;
  int? quantityRequired = 0;
  String? categoryName = '';
  bool? isUrgent = false;

  Icon urgentIcon(input) {
    if (input) {
      return const Icon(Icons.check);
    } else {
      return const Icon(Icons.close);
    }
  }

  @override
  void initState() {
    super.initState();
    categoryName = "food";
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Expanded(
            flex: 2,
            child: Form(
              key: formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  buildCategory(),
                  const SizedBox(height: 16),
                  buildItemName(),
                  const SizedBox(height: 16),
                  buildQuantityRequired(),
                  const SizedBox(height: 32),
                  buildIsUrgent(),
                  const SizedBox(height: 32),
                  buildSubmit(),
                ],
              ),
            )),
        Row(
          children: const [
            Expanded(
                flex: 1,
                child: Text("Urgent?",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                flex: 4,
                child: Text("Item Name(Amount needed)",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(child: Text(""))
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: urgentIcon(widget.list[i]["isUrgent"]),
                  title: Text(widget.list[i]["itemName"] +
                      "(${widget.list[i]["quantityRequired"].toString()})"),
                  subtitle: Text("Category: " + widget.list[i]["categoryName"]),
                  trailing: ElevatedButton(
                      child: const Text("delete"),
                      onPressed: () {
                        setState(() {
                          widget.list.removeWhere((e) =>
                              e["itemName"] == widget.list[i]["itemName"] &&
                              e["isUrgent"] == widget.list[i]["isUrgent"]);
                          widget.statefn(widget.list);
                        });
                      }),
                );
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
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          categoryName = newValue;
          itemName = null;
        });
      });

  Widget buildItemName() => DropdownSearch<String>(
      mode: Mode.MENU,
      items: itemMap[categoryName],
      selectedItem: itemName,
      label: "Select Item",
      showSearchBox: true,
      popupItemDisabled: (String s) => s.startsWith('I'),
      validator: (value) {
        if (value == null) return "Select Item";
        return null;
      },
      onChanged: (String? newValue) {
        setState(() {
          itemName = newValue;
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
            print(value);
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
      value: isUrgent,
      title: Text("Urgent?"),
      onChanged: (bool? newValue) {
        setState(() {
          isUrgent = newValue;
        });
      });

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              Map output = {
                "itemName": itemName,
                "quantityRequired": quantityRequired,
                "categoryName": categoryName,
                "isUrgent": isUrgent
              };

              void duplicateAdder() {
                bool didAdd = false;
                for (final x in widget.list) {
                  String outputItemName = output["itemName"];
                  String xItemName = x["itemName"];
                  if (xItemName == outputItemName &&
                      x["isUrgent"] == output["isUrgent"]) {
                    x["quantityRequired"] += output["quantityRequired"];
                    didAdd = true;
                    break;
                  }
                }
                if (didAdd == false) {
                  widget.list.add(output);
                }
              }

              duplicateAdder();

              widget.statefn(widget.list);
            }
          },
        ),
      );
}
