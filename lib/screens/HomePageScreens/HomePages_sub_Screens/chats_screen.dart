import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Models/location.dart';
import 'package:coffinder/Models/user_images.dart';
import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Utilities/TextStyleUtility.dart';
import 'package:coffinder/Widgets/chat_tile.dart';
import 'package:coffinder/Widgets/match_tile.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/chat_controller.dart';
import 'package:coffinder/controllers/location_controller.dart';
import 'package:coffinder/controllers/matches_controller.dart';
import 'package:coffinder/screens/HomePageScreens/HomePages_sub_Screens/MessagesScreens/messages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Models/chat.dart';
import '../../../Models/user.dart';
import '../../../fake_data.dart';
import '../../../Models/match.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final ChatController _chatController = Get.find<ChatController>();
  final MatchesController _matchesController = Get.find<MatchesController>();
  final LocationController _locationController = Get.find<LocationController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("printin");
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
                            itemCount: _matchesController.matchedUsers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              User matchedUser =
                                  _matchesController.matchedUsers[index];
                              Match match = _matchesController.matches[index];
                              return FutureBuilder<Location?>(
                                future: _locationController.getLocation(
                                    locationId: match.locationId),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Location?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Return a loading indicator if the location document is still loading
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    // Handle any errors that occurred during retrieval
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  String locationName =
                                      snapshot.data?.name ?? 'default';

                                  return Center(
                                    child: Padding(
                                      padding:
                                          PaddingUtility.xSmallLeftOnlyPadding,
                                      child: MatchTile(
                                          matchedUser: matchedUser,
                                          locationName: locationName),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('Chats'),
                ),
                Obx(() {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Chat currentChat = _chatController.currentChats[index];
                      String contactId;
                      print(
                          "participants ${_chatController.currentChats[index].chatId}");
                      if (currentChat.participants[0].toString() ==
                          authController.user.uid) {
                        contactId = currentChat.participants[1].toString();
                      } else {
                        contactId = currentChat.participants[0].toString();
                      }

                      return FutureBuilder<User?>(
                          future: authController.getUser(userId: contactId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error occurred: ${snapshot.error}');
                            } else {
                              final contactUser = snapshot.data;
                              return ChatTile(
                                title: contactUser?.name ?? "default",
                                subtitle:
                                    currentChat.lastMessage?.messageText ??
                                        "defaultlastmessage",
                                locationName: currentChat.locationName,
                                imagePath:
                                    contactUser?.userImages.images[0].imageUrl,
                                onTap: () async {
                                  User defaultUser = User(
                                      name: 'default',
                                      uid: 'default',
                                      email: 'default',
                                      gender: 'default',
                                      age: 1,
                                      userImages: UserImages(images: []));
                                  Get.to(MessagesScreen(
                                    contactUser: contactUser ?? defaultUser,
                                    chatId: currentChat.chatId,
                                  ));
                                },
                              );
                            }
                          });
                    }, childCount: _chatController.currentChats.length),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
