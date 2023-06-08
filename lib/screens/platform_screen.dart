import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

import '../Utilities/FontSizeUtility.dart';

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

  List<Container> cards = [
    Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Obx(() {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Get.find<ThemeController>().appTheme.colorScheme.primaryContainer,
                ),
              );
            }
          ),
          Positioned(
            top: 6,
            right: 6,
            left: 6,
            bottom: 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
              ),
            ),
          ),
          Positioned(
            top: 270,
            left: 6,
            right: 6,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                      'Foid, 24',
                      style: TextStyle(fontSize: FontSizeUtility.font35),
                    )),
                Container(
                  child: Text("I love fitness and sucking cocks. Buy me coffe", style: TextStyle(fontSize: FontSizeUtility.font20),),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.find<ThemeController>().appTheme.colorScheme.primaryContainer,
              ),
            );
          }
          ),
          Positioned(
            top: 6,
            right: 6,
            left: 6,
            bottom: 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
              ),
            ),
          ),
          Positioned(
            top: 270,
            left: 6,
            right: 6,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                      'Foid, 24',
                      style: TextStyle(fontSize: FontSizeUtility.font35),
                    )),
                Container(
                  child: Text("I love fitness and sucking cocks. Buy me coffe", style: TextStyle(fontSize: FontSizeUtility.font20),),
                )
              ],
            ),
          ),
        ],
      ),
    ),

    Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.find<ThemeController>().appTheme.colorScheme.primaryContainer,
              ),
            );
          }
          ),
          Positioned(
            top: 6,
            right: 6,
            left: 6,
            bottom: 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
              ),
            ),
          ),
          Positioned(
            top: 270,
            left: 6,
            right: 6,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                      'Foid, 24',
                      style: TextStyle(fontSize: FontSizeUtility.font35),
                    )),
                Container(
                  child: Text("I love fitness and sucking cocks. Buy me coffe", style: TextStyle(fontSize: FontSizeUtility.font20),),
                )
              ],
            ),
          ),
        ],
      ),
    ),

    Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.find<ThemeController>().appTheme.colorScheme.primaryContainer,
              ),
            );
          }
          ),
          Positioned(
            top: 6,
            right: 6,
            left: 6,
            bottom: 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
              ),
            ),
          ),
          Positioned(
            top: 270,
            left: 6,
            right: 6,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                      'Foid, 24',
                      style: TextStyle(fontSize: FontSizeUtility.font35),
                    )),
                Container(
                  child: Text("I love fitness and sucking cocks. Buy me coffe", style: TextStyle(fontSize: FontSizeUtility.font20),),
                )
              ],
            ),
          ),
        ],
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                child: const Icon(Icons.keyboard_arrow_left),
              ),
              FloatingActionButton(
                heroTag: 'swipeRightButton',
                onPressed: cardSwiperController.swipeRight,
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        )
      ]),
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
