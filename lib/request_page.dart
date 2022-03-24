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
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
      return Icon(Icons.check);
    } else {
      return Icon(Icons.close);
    }
  }

  @override
  void initState() {
    super.initState();
    categoryName = "food";
  }

  @override
  Widget build(BuildContext context) => Column(children: [
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
        Expanded(
          child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Urgent? "),
                    WidgetSpan(child: urgentIcon(widget.list[i]["isUrgent"]))
                  ])
                  ),
                  title: Text(widget.list[i]["itemName"]),
                  subtitle: Text("Category: " + widget.list[i]["categoryName"]),
                  trailing: Text(widget.list[i]["quantityRequired"].toString()),
                );
              }),
        )
      ]);

  Widget buildCategory() => DropdownButton(
      value: dropdownValue,
      items: categoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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

  // Widget buildItemName() => TextFormField(
  //       decoration: InputDecoration(
  //         labelText: 'item name',
  //         border: OutlineInputBorder(),
  //         // errorBorder:
  //         //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
  //         // focusedErrorBorder:
  //         //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
  //         // errorStyle: TextStyle(color: Colors.purple),
  //       ),
  //       validator: (value) {
  //         if (value == null) {
  //           return 'Enter an item name';
  //         } else if (value.length < 4) {
  //           return 'Enter at least 4 characters';
  //         } else {
  //           return null;
  //         }
  //       },
  //       maxLength: 30,
  //       onSaved: (value) => setState(() => itemName = value!),
  //     );

  Widget buildQuantityRequired() => TextFormField(

        decoration: InputDecoration(
          labelText: 'Quantity required',
          border: OutlineInputBorder(),
        ),
        validator: (String? value) {
         
          final pattern = r'(^[0-9]*$)';
          final regExp = RegExp(pattern);
          if (value == null) return 'Enter an amount';
          if (value.length== 0) {
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

  // Widget buildIsUrgent() => TextFormField(
  //       decoration: InputDecoration(
  //         labelText: 'Urgent?',
  //         border: OutlineInputBorder(),
  //       ),
  //       validator: (value) {
  //        if (value == null) {
  //           return 'enter a password';
  //         } else if (value.length < 7) {
  //           return 'Password must be at least 7 characters long';
  //         } else {
  //           return null;
  //         }
  //       },
  //       onSaved: (value) => setState(() => password = value),
  //       keyboardType: TextInputType.visiblePassword,
  //       obscureText: true,
  //     );

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


              // final message =
              //     'Username: $itemName\nPassword: $isUrgent\nEmail: $quantityRequired\nCategory: $categoryName';
              // final snackBar = SnackBar(
              //   content: Text(
              //     message,
              //     style: TextStyle(fontSize: 20),
              //   ),
              //   backgroundColor: Colors.green,
              // );
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      );

}
