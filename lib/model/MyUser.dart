
import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_database/firebase_database.dart';

class MyUser {

  String uid;
  String prenom;
  String nom;
  String imageUrl;
  String initiales;

  MyUser( DataSnapshot snapshot){
    uid = snapshot.key;
    Map map = snapshot.value;
    prenom = map["prenom"];
    nom = map["nom"];
    imageUrl = map["imageUrl"];
    initiales = (StringUtils.defaultString(prenom, defaultStr: " ")[0] + StringUtils.defaultString(nom, defaultStr: " ")[0]).trim();

  }

  Map toMap() {
    return {
      "uid": uid,
      "prenom": prenom,
      "nom": nom,
      "imageUrl": imageUrl,
      "initiales": initiales
    };
  }
}