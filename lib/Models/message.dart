import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageId;
  String senderId;
  String receiverId;
  String messageText;
  Timestamp timestamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.messageText,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'messageId': messageId,
    'senderId': senderId,
    'receiverId': receiverId,
    'messageText': messageText,
    'timestamp': timestamp,
  };

  static Message fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Message(
      messageId: data['messageId'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      messageText: data['messageText'],
      timestamp: data['timestamp'],
    );
  }
}
