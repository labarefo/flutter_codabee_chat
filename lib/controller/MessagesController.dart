

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/Conversation.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/widgets/CustomImage.dart';

class MessagesController extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _MessagesControllerState();
  }

}

class _MessagesControllerState extends State<MessagesController> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseHelper().getUserUid();
    return new Center(
      child: FirebaseAnimatedList(
          query: FirebaseHelper().entry_conv.child(uid),
          itemBuilder: (BuildContext ctx, DataSnapshot snap, Animation<double> anim, int index) {
            Conversation conversation = new Conversation(snap);
            String sub = conversation.uid == uid ? "Moi: " : "";
            sub += ("${conversation.message}");
            return new ListTile(
              leading: CustomImage(conversation.user.imageUrl, conversation.user.initiales, 20),
              title: new Text(conversation.user.fullName()),
              subtitle: new Text(sub),
              trailing: new Text(conversation.dateString),
            );
          }
      ),
    );
  }


}