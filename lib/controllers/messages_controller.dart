import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Models/message.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  //observables
  final RxList<Message> _selectedChatsMessages = <Message>[].obs;
  String _currentChatId = '';

  //getters
  List<Message> get selectedChatsMessages => _selectedChatsMessages.value;

  //methods
  Future<void> fetchMessages(
      {required String chatId, required int messageLimit}) async {
    try {
      // Unsubscribe from previous chat's messages
      if (_currentChatId.isNotEmpty) {
        _unsubscribeFromMessages(_currentChatId);
      }

      // Subscribe to new chat's messages
      _currentChatId = chatId;
      _subscribeToMessages(chatId: chatId, limit: messageLimit);
    } catch (e) {
      print("error fetching messages $e");
    }
  }

  void _subscribeToMessages({required String chatId, required int limit}) {
    _selectedChatsMessages.bindStream(firestore
        .collection('locations')
        .doc('Starbucks')
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList().reversed.toList()));
  }

  void _unsubscribeFromMessages(String chatId) {
    // TODO: Implement your logic to unsubscribe from messages with the given chatId
  }

  @override
  void onClose() {
    // Unsubscribe from the current chat's messages when the controller is closed
    _unsubscribeFromMessages(_currentChatId);
    super.onClose();
  }
}
