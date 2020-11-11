

import 'package:firebase_database/firebase_database.dart';

class Message {
  String from;
  String to;
  String text;
  String dateString;
  String imageUrl;

  Message(DataSnapshot snapshot) {
    Map map = snapshot.value;
    from = map["from"];
    to = map["to"];
    text = map["text"];
    dateString = map["dateString"];
    imageUrl = map["imageUrl"];
  }
}