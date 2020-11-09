
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat/model/MyUser.dart';

class Conversation {
  MyUser user;
  String dateString;
  String message;
  String uid;

  Conversation (DataSnapshot snapshot) {
    Map map = snapshot.value;
    user = new MyUser(snapshot);
    dateString = map["dateString"];
    message = map["lastMessage"];
    uid = map["monId"];
  }
}