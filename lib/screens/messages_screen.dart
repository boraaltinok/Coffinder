import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:coffinder/Models/chat.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utilities/QRModalBottomSheetUtility.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({required this.contactId, Key? key}) : super(key: key);
  final String contactId;


  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // Alternatively, you can use animateTo method for smooth scrolling:
    // _scrollController.animateTo(
    //   _scrollController.position.maxScrollExtent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(FakeData().getUser(userId: widget.contactId)?.name ?? "Messages"),
          ),
          SliverList(
              delegate: SliverChildListDelegate(FakeData()
                  .messages
                  .map((message) =>
                      message.senderId == FakeData().fakeCurrentUserUID &&
                              widget.contactId == message.receiverId
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
                          : message.senderId == widget.contactId
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
                              : SizedBox(
                                  width: 0,
                                  height: 0,
                                ))
                  .toList()))
        ],
      ),
    );
  }
}
