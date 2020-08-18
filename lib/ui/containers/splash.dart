import 'package:flutter/material.dart';
import 'dart:async';
import './home.dart';
import './login.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const timeout = const Duration(seconds: 3);

    void handleTimeout() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
    }

    new Timer(timeout, handleTimeout);

    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Rastahouse",
          style: Theme.of(context).textTheme.headline4,
        )
      ]),
    ));
  }
}
