

import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {
  final _auth = FirebaseAuth.instance;



  // authentification avec mail et mot de passe
  Future<User> handleSignIn(String mail, String mdp) async {
    final User user = (await _auth.signInWithEmailAndPassword(email: mail, password: mdp)).user;
    return user;
  }

  Future<void> handleSignOut() async {
    _auth.signOut();
  }

  User getUser() {
    return _auth.currentUser;
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

  addUser(String uid, Map map){
    entry_user.child(uid).set(map);
  }
}