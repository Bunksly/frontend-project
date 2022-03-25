import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:frontend/donor.dart';
import 'package:frontend/main.dart';

const users = const {
  'donors': '12345',
  'foodbank': '12345',
};

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not found';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not found';
      }
      return 'null';
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  static final FormFieldValidator<String> userValidator = (value) {
    if (value!.isEmpty) {
      return 'Please enter a username';
    } else if (value.length <= 5) {
      return 'Please use more than 5 characters';
    }
    return null;
  };

  @override
  Widget build(
    BuildContext context,
  ) {
    return FlutterLogin(
      theme: LoginTheme(
          primaryColor: Color(0x30ECE0E0),
          accentColor: Color(0xff749C75),
          inputTheme:
              InputDecorationTheme(fillColor: Color(0xff749C75), filled: true),
          buttonTheme: LoginButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
      title: 'Foodbanks App Login',
      logo: AssetImage(
          '/home/bryn/northcoders/projects/frontend-project/assets/images/classyduck.png'),
      onLogin: _authUser,
      userType: LoginUserType.name,
      userValidator: userValidator,
      onSignup: _signupUser,
      additionalSignupFields: [
        UserFormField(keyName: 'Name of organisation'),
        UserFormField(keyName: 'Email'),
        UserFormField(keyName: 'Address line 1'),
        UserFormField(keyName: 'Address line 2'),
        UserFormField(keyName: 'Postcode'),
        UserFormField(keyName: 'Phone Number')
      ],
      termsOfService: [
        TermOfService(
            id: 'foodbankOrDonor',
            mandatory: false,
            text: 'Please tick to set up a Foodbank/Charity account'),
      ],
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Donor(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
