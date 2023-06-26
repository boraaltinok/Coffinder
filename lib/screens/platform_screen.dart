import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Widgets/user_card.dart';
import 'package:coffinder/controllers/platform_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

import '../Utilities/FontSizeUtility.dart';
import '../Utilities/QRModalBottomSheetUtility.dart';

class PlatformScreen extends StatefulWidget {
  PlatformScreen({Key? key}) : super(key: key);

  @override
  State<PlatformScreen> createState() => _PlatformScreenState();
}

class _PlatformScreenState extends State<PlatformScreen> {
  late CardSwiperController cardSwiperController;

  @override
  void initState() {
    // TODO: implement initState
    cardSwiperController = CardSwiperController();
    super.initState();
  }

  @override
  void dispose() {
    cardSwiperController.dispose();
    super.dispose();
  }

  List<UserCard> cards = [
    UserCard(),
    UserCard(),
    UserCard(),
    UserCard(),
    UserCard(),
    UserCard(),
    UserCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Get.find<PlatformController>().isConnectedToPlatform ? Column(children: [
              Expanded(
                flex: 4,
                child: CardSwiper(
                  controller: cardSwiperController,
                  backCardOffset: Offset(0, 0),
                  isLoop: true,
                  onSwipe: (previousIndex, currentIndex, direction) {
                    if (direction == CardSwiperDirection.left) {
                      Get.snackbar("Title", "no way left");
                    } else if (direction == CardSwiperDirection.right) {
                      Get.snackbar("Title", "no way right");
                    } else {
                      Get.snackbar("Title", "no way");
                    }
                    return true; //if this is false it cancels swipe action
                  },
                  allowedSwipeDirection:
                      AllowedSwipeDirection.only(right: true, left: true),
                  cardsCount: cards.length,
                  cardBuilder: (context, index) => Center(child: cards[index]),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'swipeLeftButton',
                      onPressed: cardSwiperController.swipeLeft,
                      child: const Icon(Icons.close),
                    ),
                    SizedBox(
                      width: Get.width / 10,
                    ),
                    FloatingActionButton(
                      heroTag: 'swipeRightButton',
                      onPressed: cardSwiperController.swipeRight,
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              )
            ]): Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Connect to a platform to see others!",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () {
                        QRModalBottomSheetUtility.buildQRScanBottomSheet(
                            context);
                      },
                      child: const Text("CONNECT TO A PLATFORM")),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
