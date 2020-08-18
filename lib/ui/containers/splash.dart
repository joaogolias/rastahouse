import 'package:flutter/material.dart';
import 'dart:async';
import './home.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const timeout = const Duration(seconds: 3);
    const ms = const Duration(milliseconds: 1);

    void handleTimeout() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(title: "Teste")));
    }

    new Timer(timeout, handleTimeout);

    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Testeeeer",
          style: Theme.of(context).textTheme.headline4,
        )
      ]),
    ));
  }
}
