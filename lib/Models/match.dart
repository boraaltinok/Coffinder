import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  String matchId;
  String user1Id;
  String user2Id;
  String locationId;

  Match({
    required this.matchId,
    required this.user1Id,
    required this.user2Id,
    required this.locationId,
  });

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "user1Id": user1Id,
    "user2Id": user2Id,
    "locationId": locationId,
  };

  static Match fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Match(
      matchId: data['matchId'],
      user1Id: data['user1Id'],
      user2Id: data['user2Id'],
      locationId: data['locationId'],
    );
  }
}
