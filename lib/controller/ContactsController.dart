

import 'package:flutter/material.dart';

class ContactsController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _ContactsControllerState();
  }

}

class _ContactsControllerState extends State<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('Contacts'),
    );
  }


}