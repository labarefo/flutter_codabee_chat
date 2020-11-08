

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/model/MyUser.dart';

class ZoneDeTexte extends StatefulWidget {

  MyUser partenaire;
  MyUser me;


  ZoneDeTexte(this.me, this.partenaire);

  @override
  State<StatefulWidget> createState() {
    return new _ZoneDeTexteState();
  }


}

class _ZoneDeTexteState extends State<ZoneDeTexte> {
  TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(3.5),
      child: new Row(
        children: [
          new IconButton(icon: new Icon(Icons.camera_enhance), onPressed: null),
          new IconButton(icon: new Icon(Icons.photo_library), onPressed: null),
          new Flexible(
            child: new TextField(
              controller: _textController,
              decoration: new InputDecoration(hintText: "Ecrivez quelque chose"),
              maxLines: null,
            ),
          ),
          new IconButton(icon: new Icon(Icons.send), onPressed: _sendButtonPressed),

        ],
      ),
    );
  }


  void _sendButtonPressed() {
    if(StringUtils.isNotNullOrEmpty(_textController.text)){
      String text = _textController.text;
      // 1. envoyer sur forebase
      FirebaseHelper().sendMessage(widget.me, widget.partenaire, text);
      // 2. effacer
      _textController.clear();
      // 3. fermer
      FocusScope.of(context).requestFocus(FocusNode());
    }else {

    }
  }
}