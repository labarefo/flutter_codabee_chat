

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';

class LogController extends StatefulWidget {
  @override
  _LogControllerState createState() {
    return new _LogControllerState();
  }



}

class _LogControllerState extends State<LogController> {

  bool _log = true;
  String _adresseMail;
  String _password;

  String _prenom;
  String _nom;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Authentification"),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 2,
              child: new Card(
                elevation: 7.5,
                child: new Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: textFields(),
                  ),
                ),
              ),
            ),
            new FlatButton(
                onPressed: () {
                  setState(() {
                    _log = !_log;
                  });
                },
                child: new Text((_log) ? "Authentification" : "Création de compte")
            ),
            new RaisedButton(
                onPressed: () => _handleLog(),
              child: new Text("C'est parti"),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> textFields() {
    List<Widget> widgets = [];

    widgets.add(
        new TextField(
          decoration: new InputDecoration(hintText: "Adresse mail"),
          onChanged: (str){
            setState(() {
              _adresseMail = str.trim();
            });
          },
        )
    );

    widgets.add(
      new TextField(
        obscureText: true,
        decoration: new InputDecoration(hintText: "Mot de passe"),
        onChanged: (str){
          setState(() {
            _password = str.trim();
          });
        },
      )
    );

    if(!_log){
      widgets.add(
          new TextField(
            decoration: new InputDecoration(hintText: "Prénom"),
            onChanged: (str){
              setState(() {
                _prenom = str.trim();
              });
            },
          )
      );

      widgets.add(
          new TextField(
            decoration: new InputDecoration(hintText: "Nom"),
            onChanged: (str){
              setState(() {
                _nom = str.trim();
              });
            },
          )
      );
    }

    return widgets;
  }

  _handleLog() {
    if(StringUtils.isNotNullOrEmpty(_adresseMail)){
      if(StringUtils.isNotNullOrEmpty(_password)){
        if(_log){
          // connexion
          FirebaseHelper().handleSignIn(_adresseMail, _password).then((user) {
            print(user.uid);
          }).catchError((error) {
            alerte(error.toString());
          });
        }else {
          // creation de compte
          if(StringUtils.isNotNullOrEmpty(_prenom)) {
            if(StringUtils.isNotNullOrEmpty(_nom )){
              // methode pour creer un compte
              FirebaseHelper().create(_adresseMail, _password, _prenom, _nom ).then((user) {
              print(user.uid);
              }).catchError((error){
                alerte(error.toString());
              });
            }else {
              // erreur pas de nom
              alerte("Aucun nom n'a été renseigné");
            }
          }else{
            // erreur pas prenom
            alerte("Aucun prénom n'a été renseigné");
          }
        }
      }else {
        // alerte pas de mot de passe
        alerte("Aucun mot de passe n'a été renseigné");
      }
    }else {
      // alerte pas d'adresse mail
      alerte("Aucune adresse mail n'a été renseignée");
    }

  }

  Future<void> alerte(String message) async {
    Text title = new Text("Erreur");
    Text msg = new Text(message);
    FlatButton ok = new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        }, 
        child: new Text("OK")
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return (Theme.of(context).platform == TargetPlatform.iOS)
          ? CupertinoAlertDialog(title: title, content: msg, actions: [ok],)
          : AlertDialog(title: title, content: msg, actions: [ok],)
        ;
      }
    );

  }
}