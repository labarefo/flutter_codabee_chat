

import 'package:flutter/material.dart';
import 'package:flutter_chat/model/DateHelper.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/model/Message.dart';
import 'package:flutter_chat/model/MyUser.dart';
import 'package:flutter_chat/widgets/CustomImage.dart';

class ChatBubble extends StatelessWidget {

  Message message;
  MyUser partenaire;
  String myId = FirebaseHelper().getUserUid();

  Animation animation;

  ChatBubble(this.message, this.partenaire, this.animation);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        curve: Curves.easeIn,
        parent: animation,
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: bubble(myId == message.from),
        ),
      ),
    );
  }

  List<Widget> bubble(bool moi) {
    CrossAxisAlignment alignment = moi ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color color = moi ? Colors.pink[200] : Colors.blue[200];
    return <Widget> [
      moi ? new Padding(padding: EdgeInsets.all(5),) : CustomImage(partenaire.imageUrl, partenaire.initiales, 15),
      new Expanded(
        child: new Column(
          crossAxisAlignment: alignment,
          children: [
            new Text(DateHelper().convert(message.dateString)),
            new Card(
              elevation: 5,
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: color,
              child: new Container(
                padding: EdgeInsets.all(10),
                child: message.imageUrl == null ?
                new Text(message.text ?? "") : new CustomImage(message.imageUrl, null, null),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}