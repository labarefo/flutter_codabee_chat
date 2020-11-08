

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/controller/ChatController.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/model/MyUser.dart';
import 'package:flutter_chat/widgets/CustomImage.dart';

class ContactsController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _ContactsControllerState();
  }

}

class _ContactsControllerState extends State<ContactsController> {
  String uid;
  //MyUser user;

  @override
  void initState() {
    super.initState();
    uid = FirebaseHelper().getUserUid();
    
  }

  @override
  Widget build(BuildContext context) {
    return new FirebaseAnimatedList(
        query: FirebaseHelper().entry_user,
        sort: (a, b) => a.value["prenom"].toString().toLowerCase().compareTo(b.value["prenom"].toString().toLowerCase()),
        itemBuilder: (BuildContext ctx, DataSnapshot snap, Animation<double> animation, int index) {

          MyUser newUser = new MyUser(snap);
          if(uid == newUser.uid) {
            return new Container();
          }
          return new ListTile(
            leading: new CustomImage(newUser.imageUrl, newUser.initiales, MediaQuery.of(context).size.width / 20),
            title: new Text(newUser.fullName()),
            trailing: new IconButton(
                icon: new Icon(Icons.message),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext ctx){
                    return new ChatController(newUser);
                  }));
                }
            ),
          );
        }
    );
  }


}