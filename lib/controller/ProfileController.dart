

import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/model/MyUser.dart';

class ProfileController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _ProfileControllerState();
  }

}

class _ProfileControllerState extends State<ProfileController> {

  MyUser user;
  String uid = FirebaseHelper().getUserUid();

  String prenom;
  String nom;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ?
    new Center(child: new Text('Chargement...'),)
    :
    SingleChildScrollView(
      child: new Container(
        margin: EdgeInsets.all(20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new TextField(
              decoration: new InputDecoration(hintText: "Prénom"),
              controller: new TextEditingController(text: user.prenom),
              onChanged: (str){
                prenom = str;
              },
            ),
            new TextField(
              decoration: new InputDecoration(hintText: "Nom"),
              controller: new TextEditingController(text: user.nom),
              onChanged: (str){
                nom = str;
                print(nom);
              },
            ),
            new RaisedButton(
                onPressed: saveChanges,
                child: new Text("Sauvegarder"),
            ),
            new FlatButton(
                onPressed: logOut,
                child: new Text("Se déconnecter")
            )
          ],
        ),
      ),
    )
    ;
  }

  Future<void> logOut(){
    Text title = new Text("Sé déconnecter");
    Text content = new Text("Êtes vous sur de vouloir vous déconnecter ?");
    FlatButton noBtn = new FlatButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: new Text("Non")
    );

    FlatButton yesBtn = new FlatButton(
        onPressed: (){
          FirebaseHelper().handleSignOut().then((bool) {
            Navigator.of(context).pop();
          });
        },
        child: new Text("Oui")
    );
    
    return showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx){
          if(Theme.of(context).platform == TargetPlatform.iOS){
            return new CupertinoAlertDialog(
              title: title,
              content: content,
              actions: [
                yesBtn,
                noBtn
              ],
            );
          }
          return new AlertDialog(
            title: title,
            content: content,
            actions: [
              yesBtn,
              noBtn
            ],
          );
      }

    );
  }
  
  
  saveChanges() {
    Map map = {};
    if(StringUtils.isNotNullOrEmpty(prenom)){
      map["prenom"] = prenom;
    }
    if(StringUtils.isNotNullOrEmpty(nom)){
      map["nom"] = nom;
    }
    if(map.length > 1) {
      FirebaseHelper().addUser(uid, map).then((value) {
        _getUser();
      });
    }
    
  }

  void _getUser() {
    FirebaseHelper().getUser(uid).then((me) {
      setState(() {
        user = me;
        prenom = user.prenom;
        nom = user.nom;
      });
    });
  }
  

}