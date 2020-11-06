

import 'package:flutter/material.dart';

class MainAppController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter chat"),
      ),
      body: new Center(
        child: new Text("Nous sommes connectés"),
      ),
    );
  }

}