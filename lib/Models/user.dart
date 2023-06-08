import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePhoto;
  String email;
  String uid;
  String gender;

  User(
      {required this.name,
      required this.uid,
      required this.email,
      required this.profilePhoto,
      required this.gender});

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
        "gender": gender
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        uid: snapshot['uid'],
        email: snapshot['email'],
        profilePhoto: snapshot['profilePhoto'],
        gender: snapshot['gender']);
  }
}
