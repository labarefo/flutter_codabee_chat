

import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/model/MyUser.dart';
import 'package:image_picker/image_picker.dart';

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
          new IconButton(icon: new Icon(Icons.camera_enhance), onPressed: () => takeAPic(ImageSource.camera)),
          new IconButton(icon: new Icon(Icons.photo_library), onPressed: () => takeAPic(ImageSource.gallery)),
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
      FirebaseHelper().sendMessage(widget.me, widget.partenaire, text, null);
      // 2. effacer
      _textController.clear();
      // 3. fermer
      FocusScope.of(context).requestFocus(FocusNode());
    }else {

    }
  }

  Future<void> takeAPic(ImageSource source) async {
    PickedFile picked = await ImagePicker().getImage(source: source, maxWidth: 1000, maxHeight: 1000);
    if(picked != null) {
      File file = new File(picked.path);

      String date = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseHelper().entryStorageMessage.child(widget.me.uid).child(date);
      FirebaseHelper().savePic(file, reference).then((imageUrl) {
        FirebaseHelper().sendMessage(widget.me, widget.partenaire, null, imageUrl);
      });

    }
  }
}