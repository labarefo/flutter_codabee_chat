

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';

class ProfileController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _ProfileControllerState();
  }

}

class _ProfileControllerState extends State<ProfileController> {
  User user = FirebaseHelper().getUser();
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('Profile: ${user.uid}'),
    );
  }


}