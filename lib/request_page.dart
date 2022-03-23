import 'package:flutter/material.dart';
import 'package:frontend/widget/button_widget.dart';

class RequestPage extends StatelessWidget {
  static final String title = "request page";
  //const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(title),
        ),
        body: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {


  const MainPage({
    Key? key,
   
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();
  String? itemName = '';
  String? amount = '';
  bool? isUrgent = false;

  @override
  Widget build(BuildContext context) =>
        Form(
          key: formKey,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              buildItemName(),
              const SizedBox(height: 16),
              buildAmount(),
              const SizedBox(height: 32),
              buildIsUrgent(),
              const SizedBox(height: 32),
              buildSubmit(),
            ],
          ),
        
      );

  Widget buildItemName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'item name',
          border: OutlineInputBorder(),
          // errorBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          // focusedErrorBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          // errorStyle: TextStyle(color: Colors.purple),
        ),
        validator: (value) {
          if (value == null) {
            return 'Enter at least 4 characters';
          } else if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => itemName = value!),
      );

  Widget buildAmount() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Amount',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          final pattern = r'(^[0-9]*$)';
          final regExp = RegExp(pattern);
          if (value == null) {
            return 'Enter an amount';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid amount';
          } else {
            return null;
          }
        },
        maxLength: 3,
        // keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => amount = value),
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

              final message =
                  'Username: $itemName\nPassword: $isUrgent\nEmail: $amount';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      );
}
