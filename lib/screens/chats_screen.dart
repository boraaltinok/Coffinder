import 'package:coffinder/Widgets/chat_tile.dart';
import 'package:coffinder/screens/messages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/chat.dart';
import '../Utilities/QRModalBottomSheetUtility.dart';
import '../fake_data.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late List<Chat> fakeChats;

  @override
  void initState() {
    // TODO: implement initState
    fakeChats = FakeData().returnFakeChatModels();
    super.initState();
    print("printing");
    print(fakeChats[0].participants[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Chats'),
          ),
          SliverList(
              delegate: SliverChildListDelegate(fakeChats
                  .map((chat) => ChatTile(
                        title: FakeData()
                                .getUser(userId: chat.participants[1])
                                ?.name ??
                            "default",
                        subtitle: chat.lastMessage.messageText,
                        locationName: chat.locationName,
                        onTap: () {
                          Get.to(MessagesScreen(
                            contactId: FakeData()
                                    .getUser(userId: chat.participants[1])
                                    ?.uid ??
                                '2',
                          ));
                        },
                      ))
                  .toList()))
        ],
      ),
    );
  }
}
