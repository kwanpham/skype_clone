import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone/resources/firebase_repository.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FireBaseRepository _repository = FireBaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginButton(),
    );
  }

  Widget loginButton() {
    return FlatButton(
        padding: EdgeInsets.all(35),
        onPressed: () => performLogin(),
        child: Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ));
  }

  void performLogin() {
    print("tring to perform login");
    _repository.signIn().then((User user) {
      print("something");
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(User user) {
    _repository.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }))
            });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
