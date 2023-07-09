import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Utilities/FontSizeUtility.dart';
import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Utilities/TextStyleUtility.dart';
import 'package:coffinder/controllers/platform_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/screens/HomePageScreens/HomePages_sub_Screens/MessagesScreens/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../Models/user.dart';
import 'package:get/get.dart';

class MatchedBottomSheet extends StatelessWidget {
  const MatchedBottomSheet(
      {Key? key, required this.swipedUser, required this.currentUser})
      : super(key: key);

  final User swipedUser;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Get.find<ThemeController>().appTheme.colorScheme.primary,
                      Get.find<ThemeController>()
                          .appTheme
                          .colorScheme
                          .onPrimary,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                child: Padding(
                  padding: PaddingUtility.smallAllPadding,
                  child: SizedBox(
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: FontSizeUtility.font40,
                                      ))
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "IT IS A MATCH",
                                      style: TextStyleUtility.matchedTextStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: CachedNetworkImageProvider(
                                            currentUser.userImages.images[0].imageUrl,
                                          ),
                                          radius: FontSizeUtility.font40 * 2,
                                        ),
                                        CircleAvatar(
                                          backgroundImage: CachedNetworkImageProvider(
                                            swipedUser.userImages.images[0].imageUrl,
                                          ),
                                          radius: FontSizeUtility.font40 * 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: PaddingUtility.xSmallHeightOnlyPadding,
                                    child: SizedBox(
                                      width: Get.width,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0, side: const BorderSide(width: 2)),
                                          onPressed: () {
                                            Get.to(()=>MessagesScreen(contactUser: swipedUser,));
                                          },
                                          child: Text("Send a message", style: TextStyleUtility.mediumHeaderTextStyle,)),
                                    ),
                                  ),
                                  Padding(
                                    padding: PaddingUtility.xSmallHeightOnlyPadding,
                                    child: SizedBox(
                                      width: Get.width,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0, side: const BorderSide(width: 2)),
                                          onPressed: () {},
                                          child: Text("Offer to buy a coffee", style: TextStyleUtility.mediumHeaderTextStyle)),
                                    ),
                                  ),
                                  Padding(
                                    padding: PaddingUtility.xSmallHeightOnlyPadding,
                                    child: SizedBox(
                                      width: Get.width,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0, side: const BorderSide(width: 2)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Keep swiping", style: TextStyleUtility.mediumHeaderTextStyle)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex:2,child: SizedBox())
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
