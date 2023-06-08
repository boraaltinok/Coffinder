import 'package:cloud_firestore/cloud_firestore.dart';

class Swipe {
  String swipeId;
  String swiperId;
  String swipedUserId;
  String locationId;

  Swipe({
    required this.swipeId,
    required this.swiperId,
    required this.swipedUserId,
    required this.locationId,
  });

  Map<String, dynamic> toJson() => {
    "swipeId": swipeId,
    "swiperId": swiperId,
    "swipedUserId": swipedUserId,
    "locationId": locationId,
  };

  static Swipe fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Swipe(
      swipeId: data['swipeId'],
      swiperId: data['swiperId'],
      swipedUserId: data['swipedUserId'],
      locationId: data['locationId'],
    );
  }
}
