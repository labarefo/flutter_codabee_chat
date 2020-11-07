
import 'package:flutter/material.dart';
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
              child: new Container(
                color: Colors.red,
              ),
            ),

            Divider(height: 2,),

            new ZoneDeTexte(widget.partenaire)
          ],
        ),
      ),
    );
  }

}