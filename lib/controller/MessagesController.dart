

import 'package:flutter/material.dart';

class MessagesController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _MessagesControllerState();
  }

}

class _MessagesControllerState extends State<MessagesController> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('Messages'),
    );
  }


}