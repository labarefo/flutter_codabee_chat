
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/model/FirebaseHelper.dart';
import 'package:flutter_chat/model/Message.dart';
import 'package:flutter_chat/model/MyUser.dart';
import 'package:flutter_chat/widgets/CustomImage.dart';
import 'package:flutter_chat/widgets/ZoneDeTexte.dart';

class ChatController extends StatefulWidget {
  MyUser partenaire;


  ChatController(this.partenaire);

  @override
  State<StatefulWidget> createState() => new _ChatControllerState();

}

class _ChatControllerState extends State<ChatController> {

  MyUser me;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseHelper().getUser(FirebaseHelper().getUserUid()).then((value) {
      setState(() {
        this.me = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new CustomImage(widget.partenaire.imageUrl, widget.partenaire.initiales, MediaQuery.of(context).size.width / 22),
            new Text(widget.partenaire.fullName())
          ],
        ),
      ),
      body: new InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new Column(

          children: [
            Flexible(
              child: (me == null)
              ? Center(child: new Text("Chargement..."))
              : FirebaseAnimatedList(
                  query: FirebaseHelper().getConversationsRef(me, widget.partenaire),
                  sort: (a, b) => a.key.compareTo(b.key),
                  itemBuilder: (BuildContext ctx, DataSnapshot snap,  Animation<double> animation, int index){
                    Message msg = new Message(snap);
                    return ListTile(
                      title: new Text(snap.value["text"]),
                    );
                  }
              ),
            ),

            Divider(height: 2,),

            new ZoneDeTexte(this.me, widget.partenaire)
          ],
        ),
      ),
    );
  }

}