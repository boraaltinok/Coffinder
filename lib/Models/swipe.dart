import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Enums/SwipeTypeEnum.dart';

class Swipe {
  String swipeId;
  String swiperId;
  String swipedUserId;
  String locationId;
  SwipeTypeEnum swipeDirection;

  Swipe({
    required this.swipeId,
    required this.swiperId,
    required this.swipedUserId,
    required this.locationId,
    required this.swipeDirection
  });

  Map<String, dynamic> toJson() => {
    "swipeId": swipeId,
    "swiperId": swiperId,
    "swipedUserId": swipedUserId,
    "locationId": locationId,
    "swipeDirection" : swipeDirection.value.toString()
  };

  static Swipe fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Swipe(
      swipeId: data['swipeId'],
      swiperId: data['swiperId'],
      swipedUserId: data['swipedUserId'],
      locationId: data['locationId'],
      swipeDirection: getSwipeTypeEnumFromString(data['swipeDirection']), // Use the helper function to convert the string value
    );
  }
}
