import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Utilities/TextStyleUtility.dart';
import 'package:coffinder/Widgets/chat_tile.dart';
import 'package:coffinder/Widgets/match_tile.dart';
import 'package:coffinder/screens/messages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../Models/chat.dart';
import '../Utilities/QRModalBottomSheetUtility.dart';
import '../fake_data.dart';
import '../Models/match.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late List<Chat> fakeChats;
  late List<Match> fakeMatches;

  @override
  void initState() {
    // TODO: implement initState
    fakeChats = FakeData().returnFakeChatModels();
    fakeMatches = FakeData().fakeMatches;
    super.initState();
    print("printing");
    print(fakeChats[0].participants[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text("Matches",
                        style: TextStyleUtility.bigHeaderTextStyle)),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: ListView.builder(
                              itemCount: 15,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Padding(
                                      padding: PaddingUtility
                                          .xSmallLeftOnlyPadding,
                                      child: MatchTile()),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text('Chats'),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(fakeChats
                        .map((chat) => ChatTile(
                              imagePath: FakeData()
                                  .getUser(userId: chat.participants[1])
                                  ?.userImages.images[0].imageId,
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
          ),
        ],
      ),
    );
  }
}
