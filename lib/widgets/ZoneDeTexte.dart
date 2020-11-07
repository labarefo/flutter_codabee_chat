

import 'package:flutter/material.dart';
import 'package:flutter_chat/model/MyUser.dart';

class ZoneDeTexte extends StatefulWidget {

  MyUser partenaire;


  ZoneDeTexte(this.partenaire);

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
          new IconButton(icon: new Icon(Icons.send), onPressed: null),

        ],
      ),
    );
  }

}