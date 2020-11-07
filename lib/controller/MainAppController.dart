

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/controller/ContactsController.dart';
import 'package:flutter_chat/controller/MessagesController.dart';
import 'package:flutter_chat/controller/ProfileController.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';

class MainAppController extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    if(platform == TargetPlatform.iOS) {
      return new CupertinoTabScaffold(
          tabBar: new CupertinoTabBar(
              backgroundColor: Colors.blue,
              activeColor: Colors.black,
              inactiveColor: Colors.white,
              items: [
                BottomNavigationBarItem(icon: new Icon(Icons.message)),
                BottomNavigationBarItem(icon: new Icon(Icons.supervisor_account)),
                BottomNavigationBarItem(icon: new Icon(Icons.account_circle)),
              ],

          ),

          tabBuilder: (BuildContext cts, index) {
            Widget selectedController = controllers()[index];
            return new Scaffold(
              appBar: new AppBar(title: new Text("Flutter Chat"),),
              body: selectedController,
            );
          }
      );
    }else{
      return DefaultTabController(
          length: 3,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text("Flutter Chat"),
              bottom: new TabBar(
                  tabs: [
                    Tab(icon: new Icon(Icons.message),),
                    Tab(icon: new Icon(Icons.supervisor_account),),
                    Tab(icon: new Icon(Icons.account_circle),)
                  ]
              ),
            ),
            body: TabBarView(
                children: controllers()
            ),
          )
      );
    }
  }

  List<Widget> controllers() {
    return [
      MessagesController(),
      ContactsController(),
      ProfileController()
    ];
  }
}