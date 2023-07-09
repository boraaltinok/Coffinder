import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/chat_controller.dart';
import 'package:coffinder/controllers/messages_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Models/user.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({required this.contactUser, this.chatId, Key? key})
      : super(key: key);
  final User contactUser;
  final String? chatId;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late ScrollController _scrollController;
  final TextEditingController _messageEditingController =
      TextEditingController();
  late bool isChatAlreadyCreated;
  late ChatController _chatController;
  late MessagesController _messageController;

  /// When user navigates to messages screen from matched screen, the chat is not created without it's first message
  String currentChatId = '';

  @override
  void initState() {
    // TODO: implement initState
    _chatController = Get.find<ChatController>();
    _messageController = Get.find<MessagesController>();

    /// if isChatAlreadyCreated is false it means that participants already have the chat(there is at least one message)
    isChatAlreadyCreated = widget.chatId == null ? false : true;

    if (isChatAlreadyCreated) {
      /// if isChatAlreadyCreated is false it means that participants already have the chat(there is at least one message)
      currentChatId = widget.chatId!;
      _messageController.fetchMessages(chatId: currentChatId, messageLimit: 20);
    }
    _scrollController = ScrollController();

    ///automatically scroll to the bottom of the scrollable message area
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageEditingController.dispose();
    super.dispose();
  }

  ///scroll to the bottom of the scrollController
  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                CupertinoSliverNavigationBar(
                  trailing: SizedBox(
                    width: Get.width / 5,
                    // in order to not take whole row and block large title
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.block_outlined,
                              color: Get.find<ThemeController>()
                                  .appTheme
                                  .colorScheme
                                  .error,
                            ))
                      ],
                    ),
                  ),
                  largeTitle: Text(widget.contactUser.name),
                ),
                Obx(() {
                  return SliverList(
                      delegate: SliverChildListDelegate(_messageController
                          .selectedChatsMessages
                          .map((message) => message.senderId ==
                                      authController.user.uid &&
                                  widget.contactUser.uid == message.receiverId
                              ? BubbleSpecialThree(
                                  text: message.messageText,
                                  textStyle: TextStyle(
                                      color: Get.find<ThemeController>()
                                          .appTheme
                                          .colorScheme
                                          .onPrimary),
                                  color: Get.find<ThemeController>()
                                      .appTheme
                                      .colorScheme
                                      .primary,
                                  tail: true,
                                )
                              : message.senderId == widget.contactUser.uid
                                  ? BubbleSpecialThree(
                                      text: message.messageText,
                                      textStyle: TextStyle(
                                          color: Get.find<ThemeController>()
                                              .appTheme
                                              .colorScheme
                                              .onSecondary),
                                      color: Get.find<ThemeController>()
                                          .appTheme
                                          .colorScheme
                                          .secondary,
                                      tail: true,
                                      isSender: false,
                                    )
                                  : const SizedBox(
                                      width: 0,
                                      height: 0,
                                    ))
                          .toList()));
                })
              ],
            ),
          ),
          Padding(
            padding: PaddingUtility.xSmallAllPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_a_photo_outlined)),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'type something',
                    controller: _messageEditingController,
                  ),
                ),
                IconButton(
                    onPressed: handleOnSendMessageButtonPressed,
                    icon: const Icon(Icons.send_sharp)),
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleOnSendMessageButtonPressed() async {
    String txtContent = _messageEditingController.text.toString();

    /// get the text message
    String receiverId = widget.contactUser.uid;

    /// get the receiver's id
    bool isChatEmpty = await _chatController.isChatEmpty(chatId: currentChatId);
    if (isChatEmpty) {
      ///inside if the currentChat has no messages or null, then create and send the initial message
      currentChatId = await _chatController.createChat(
          participants: [authController.user.uid, widget.contactUser.uid],
          locationId: '1',
          initialMessageText: _messageEditingController.text.toString());
      isChatAlreadyCreated = true;

      _messageController.fetchMessages(chatId: currentChatId, messageLimit: 20);
    } else {
      ///send the message
      await _chatController.sendMessage(
          receiverId: receiverId,
          txtContent: txtContent,
          chatId: currentChatId);
    }
  }
}
