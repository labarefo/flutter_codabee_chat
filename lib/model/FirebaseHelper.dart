

import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat/model/MyUser.dart';

class FirebaseHelper {
  final _auth = FirebaseAuth.instance;



  // authentification avec mail et mot de passe
  Future<User> handleSignIn(String mail, String mdp) async {
    final User user = (await _auth.signInWithEmailAndPassword(email: mail, password: mdp)).user;
    return user;
  }

  Future<bool> handleSignOut() async {
    await _auth.signOut();
    return true;
  }

  String getUserUid() {
    return _auth.currentUser.uid;
  }

  Future<MyUser> getUser(String uid) async {
    DataSnapshot snapshot = await entry_user.child(uid).once();
    MyUser user = new MyUser(snapshot);
    return user;
  }

  Future<User> create(String mail, String mdp, String prenom, String nom) async{
    final create = await _auth.createUserWithEmailAndPassword(email: mail, password: mdp);
    final User user = create.user;
    String uid = user.uid;
    String initiales = (StringUtils.defaultString(prenom, defaultStr: " ")[0] + StringUtils.defaultString(nom, defaultStr: " ")[0]).trim();
    Map map = {
      "prenom": prenom,
      "nom": nom,
      "uid": uid,
      "initiales": initiales
    };
    addUser(uid, map);
    return user;
  }


  // Database

  static final entryPoint = FirebaseDatabase.instance.reference();
  final entry_user = entryPoint.child("users");
  final entry_message = entryPoint.child("messages");
  final entry_conv = entryPoint.child("conversations");

  Future<void> addUser(String uid, Map map) async {
    await entry_user.child(uid).set(map);
  }


  Future sendMessage (MyUser me, MyUser partenaire , String texte, String imageUrl) async {
    String ref = _getMessageRef(me.uid, partenaire.uid);
    String dateStr = DateTime.now().millisecondsSinceEpoch.toString();
    Map map = {
      "from": me.uid,
      "to": partenaire.uid,
      "text": texte,
      "dateString": dateStr,
      "imageUrl": imageUrl
    };
    
    entry_message.child(ref).child(dateStr).set(map);

    entry_conv.child(me.uid)        .child(partenaire.uid).set(builConversation(partenaire, me.uid, texte, dateStr));
    entry_conv.child(partenaire.uid).child(me.uid        ).set(builConversation(me        , me.uid, texte, dateStr));
  }

  Map builConversation(MyUser user, String sender, String last, String dateString) {
    Map map = user.toMap();
    map["monId"] = sender;
    map["lastMessage"] = last;
    map["dateString"] = dateString;

    return map;
  }

  String _getMessageRef(String from, String to) {
    List<String> list = [from, to];
    list.sort((a,b) => a.compareTo(b));
    String ref = list.join("+");
    return ref;
  }

  DatabaseReference getConversationsRef(MyUser from, MyUser to) {
    return entry_message.child(_getMessageRef(from.uid, to.uid));
  }


  static final entryStorage = FirebaseStorage.instance.ref();
  final entryStorageUser = entryStorage.child("users");
  final entryStorageMessage = entryStorage.child("messages");

  Future<String> savePic(File file, Reference reference) async {
    UploadTask uploadTask = reference.putFile(file);

    return uploadTask.snapshot.ref.getDownloadURL();
  }

}