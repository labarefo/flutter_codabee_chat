

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

  Future<void> addUser(String uid, Map map) async {
    await entry_user.child(uid).set(map);
  }

  static final entryStorage = FirebaseStorage.instance.ref();
  static final entryStorageUser = entryStorage.child("user");

  Future<String> savePic(File file, String uid) async {
    Reference reference = entryStorageUser.child(uid);
    UploadTask task = reference.putFile(file);
    TaskSnapshot snapshot = task.snapshot;
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }

}