import 'package:cloud_firestore/cloud_firestore.dart';

import 'message.dart';

class Chat {
  String chatId;
  List<String> participants;
  Message? lastMessage;
  String locationId; // Add location ID field
  String locationName; // Add location name field


  Chat({
    required this.chatId,
    required this.participants,
    this.lastMessage,
    required this.locationId,
    required this.locationName,
  });

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'participants': participants,
    'locationId': locationId,
    'locationName': locationName,
    'lastMessage': lastMessage?.toJson(),
  };

  static Chat fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    Message lastMessage = Message.fromMap(data['lastMessage']);

    return Chat(
      chatId: data['chatId'],
      participants: List<String>.from(data['participants']),
      locationId: data['locationId'],
      locationName: data['locationName'],
      lastMessage: lastMessage,
    );
  }
}
