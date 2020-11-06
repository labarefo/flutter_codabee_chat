

import 'package:flutter/material.dart';

class LogController extends StatefulWidget {
  @override
  _LogControllerState createState() {
    return new _LogControllerState();
  }



}

class _LogControllerState extends State<LogController> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Authentification"),
      ),
      body: new Center(child: new Text("Auth"),),
    );
  }

}