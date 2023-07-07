import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  String matchId;
  String currentUserId;
  String matchedUserId;
  String locationId;
  bool isShown;

  Match({
    required this.matchId,
    required this.currentUserId,
    required this.matchedUserId,
    required this.locationId,
    this.isShown = false,
  });

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "currentUserId": currentUserId,
    "matchedUserId": matchedUserId,
    "locationId": locationId,
    "isShown": isShown
  };

  static Match fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Match(
      matchId: data['matchId'],
        currentUserId: data['currentUserId'],
        matchedUserId: data['matchedUserId'],
      locationId: data['locationId'],
      isShown: data['isShown']
    );
  }
}
