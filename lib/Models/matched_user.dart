import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Models/user_images.dart';

class MatchedUser {

  String uid;

  MatchedUser(
      {
        required this.uid,});

  Map<String, dynamic> toJson() => {
    'uid': uid,
  };

  static MatchedUser fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return MatchedUser(
        uid: data['uid'],
    );
  }
}
