import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Models/chat.dart';
import 'package:coffinder/Models/message.dart';
import 'package:coffinder/Utilities/RandomIdGenerator.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class ChatController extends GetxController {
  final RxList<Chat> _currentChats = <Chat>[].obs;

  List<Chat> get currentChats => _currentChats.value;

  final Chat _defaultChat = Chat(
      chatId: 'default',
      participants: [],
      lastMessage: Message(
          messageId: '',
          senderId: '',
          receiverId: '',
          messageText: '',
          timestamp: Timestamp.now()),
      locationId: 'default',
      locationName: 'default');

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _bindCurrentChats();
  }

  void _bindCurrentChats() {
    _currentChats.bindStream(firestore
        .collection('locations')
        .doc('Starbucks')
        .collection('chats')
        .snapshots()
        .asyncMap((QuerySnapshot query) async {
      if (query.docs.isEmpty) {
        // Handle empty snapshot here
        print("CURRENTLY CHATS ARE EMPTY");
        return [];
      } else {
        List<String> currentChatIds = query.docs.map((doc) => doc.id).toList();
        List<Chat> tmpCurrentChats = [];

        for (String currentChatId in currentChatIds) {
          print("FOUND A CHAT $currentChatId");
          Chat chat = await getChat(chatId: currentChatId);
          print("await getChat result id : ${chat.chatId}");
          tmpCurrentChats.add(chat);
        }
        return tmpCurrentChats;
      }
    }));
  }

  Future<String> createChat({required List<
      String> participants, required String locationId, required String initialMessageText}) async {
    if (participants.length != 2) {
      throw ArgumentError(
          'Participants list must contain exactly two participants.');
    }
    String result = 'empty';
    Chat chat = _defaultChat;
    try {
      String randomChatId = RandomIdGenerator.generateUniqueId();
      String randomMessageId = RandomIdGenerator.generateUniqueId();
      String currentUserId = authController.user.uid;
      String receiverId;
      if(participants[0] == currentUserId){
        receiverId = participants[1];
      }else{
        receiverId = participants[0];

      }

      Message initialMessage = Message(messageId: randomMessageId,
          senderId: currentUserId,
          receiverId: receiverId,
          messageText: initialMessageText,
          timestamp: Timestamp.now());

      chat = Chat(
          chatId: randomChatId,
          participants: participants,
          locationId: locationId,
          locationName: 'Starbucks',
          lastMessage: initialMessage);

      await firestore
          .collection('locations')
          .doc('Starbucks')
          .collection('chats')
          .doc(randomChatId)
          .set(chat.toJson());

      await sendMessage(receiverId: receiverId, txtContent: initialMessageText, chatId: randomChatId);


      result = randomChatId;
    } catch (e) {
      print("Error creating chat $e");
    }
    return result;
  }

  Future sendMessage(
      {required String receiverId, required String txtContent, required String chatId }) async {
    try {
      String randomId = RandomIdGenerator.generateUniqueId();
      String currentUserId = authController.user.uid;
      Timestamp currentTimestamp = Timestamp.now();
      Message message = Message(messageId: randomId,
          senderId: currentUserId,
          receiverId: receiverId,
          messageText: txtContent,
          timestamp: currentTimestamp);

      await firestore
          .collection('locations')
          .doc('Starbucks')
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(randomId)
          .set(message.toJson());
      _setChatsLastMessage(chatId: chatId, lastMessage: message);
    } catch (e) {
      print("Error sending message $e");
    }
  }

  ///CHECKS WHETHER OR NOT CHAT CONTAINS A MESSAGE
  Future<bool> isChatEmpty({required chatId}) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('locations')
          .doc('Starbucks')
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .limit(1) // Limit the query to retrieve only one message
          .get();

      return snapshot.docs
          .isEmpty; // Return true if no message exists in the chat
    } catch (e) {
      print('Error checking if chat is empty: $e');
      return true; // Consider chat as empty in case of any error
    }
  }

  Future<Chat> getChat({required chatId}) async {
    Chat chat = _defaultChat;
    try {
      DocumentSnapshot doc = await firestore
          .collection('locations')
          .doc('Starbucks')
          .collection('chats')
          .doc(chatId)
          .get();

      print("about to call fromSnap ");
      chat = Chat.fromSnapshot(doc);
      print("fromSnap called ${chat.chatId}");
    } catch (e) {
      print("errorrrr $e");
      Get.snackbar('Error Retrieving', e.toString());
    }
    return chat;
  }

  Future _setChatsLastMessage(
      {required chatId, required Message lastMessage}) async {
    try {
      // Get the reference to the chat document
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('locations')
          .doc('Starbucks')
          .collection('chats')
          .doc(chatId);

      // Update the 'lastMessage' field in the document
      await docRef.update({'lastMessage': lastMessage.toJson()});
    } catch (e) {
      print("error setting the last message $e");
    }
  }
}
