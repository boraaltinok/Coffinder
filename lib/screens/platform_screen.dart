import 'package:coffinder/Enums/SwipeTypeEnum.dart';
import 'package:coffinder/Models/user_images.dart';
import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Utilities/SnackBarUtility.dart';
import 'package:coffinder/Widgets/user_card.dart';
import 'package:coffinder/Widgets/user_platform_card.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/platform_controller.dart';
import 'package:coffinder/screens/MatchedBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

import '../Models/user.dart';
import '../Utilities/QRModalBottomSheetUtility.dart';

class PlatformScreen extends StatefulWidget {
  const PlatformScreen({Key? key}) : super(key: key);

  @override
  State<PlatformScreen> createState() => _PlatformScreenState();
}

class _PlatformScreenState extends State<PlatformScreen> {
  late CardSwiperController cardSwiperController;

  late List<UserCard> cards;
  final PlatformController _platformController = Get.find<PlatformController>();

  @override
  void initState() {
    // TODO: implement initState
    cardSwiperController = CardSwiperController();
    cards = [
      UserCard(
        userName: 'Foid1',
        age: '',
        bio: 'bio1' * 5,
        selectedImage: '',
      ),
      UserCard(
        userName: 'Foid2',
        age: '',
        bio: 'bio2' * 5,
        selectedImage: '',
      ),
      /*
        UserCard(
          userName: 'Foid3',
          age: '',
          bio: 'bio3' * 5,
        ),
        UserCard(
          userName: 'Foid4',
          age: '',
          bio: 'bio4' * 5,
        ),
        UserCard(
          userName: 'Foid5',
          age: '',
          bio: 'bio5' * 5,
        ),
        UserCard(
          userName: 'Foid6',
          age: '',
          bio: 'bio6' * 5,
        ),
        UserCard(
          userName: 'Foid7',
          age: '',
          bio: 'bio7' * 5,
        ),*/
    ];

// Add connected users to the cards list

    super.initState();
  }

  @override
  void dispose() {
    cardSwiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Obx buildBody(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: Get.width,
        height: Get.height,
        child: _platformController.isConnectedToPlatform
            ? _platformController.connectedUsers.isEmpty
                ? buildEmptyUserList()
                : Column(children: [
                    Expanded(
                      flex: 4,
                      child: buildCardSwiper(),
                    ),
                    Expanded(
                      flex: 1,
                      child: buildCardActionsRow(),
                    )
                  ])
            : buildUnconnectedToPlatform(context),
      );
    });
  }

  Row buildCardActionsRow() {
    return Row(
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
    );
  }

  CardSwiper buildCardSwiper() {
    return CardSwiper(
      numberOfCardsDisplayed: 2,
      controller: cardSwiperController,
      backCardOffset: const Offset(0, 0),
      padding: PaddingUtility.xSmallAllPadding,
      isLoop: false,
      onSwipe: (previousIndex, currentIndex, direction) async {
        print(
            "onSwipe previousIndex $previousIndex currentIndex $currentIndex");
        if (direction == CardSwiperDirection.left) {
          String swipedUserId =
              _platformController.connectedUsers[previousIndex].uid;
          bool isMatched = await _platformController.handleSwipe(
              swipeTypeEnum: SwipeTypeEnum.left, swipedUserId: swipedUserId);
          Get.snackbar("Title", "no way left");
        } else if (direction == CardSwiperDirection.right) {
          Get.snackbar("Title", "no way right");
          String swipedUserId =
              _platformController.connectedUsers[previousIndex].uid;
          bool isMatched = await _platformController.handleSwipe(
              swipeTypeEnum: SwipeTypeEnum.right, swipedUserId: swipedUserId);

          if (isMatched) {
            User? matchedUser =
                await authController.getUser(userId: swipedUserId);
            SnackBarUtility.showCustomSnackbar(
                title: 'MATCHEDD',
                message: 'MATCHEDD',
                icon: const Icon(Icons.add_alert_rounded));
            User? currentUser =
                await authController.getUser(userId: authController.user.uid);

            User defaultUser = User(
                name: 'default',
                uid: 'default',
                email: 'default',
                gender: 'default',
                age: 1,
                userImages: UserImages(images: []));
            if (context.mounted) {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  barrierColor: Colors.white.withOpacity(0),
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return MatchedBottomSheet(
                        currentUser: currentUser ?? defaultUser,
                        swipedUser: matchedUser ?? defaultUser);
                  });
            } else {
              SnackBarUtility.showCustomSnackbar(
                  title: 'context not mounted',
                  message: 'context not mounted',
                  icon: Icon(Icons.error));
            }
          }
        } else {
          Get.snackbar("Title", "no way");
        }
        return true; //if this is false it cancels swipe action
      },
      allowedSwipeDirection:
          AllowedSwipeDirection.only(right: true, left: true),
      cardsCount: _platformController.connectedUsers.length < 2
          ? _platformController.connectedUsers.length
          : _platformController.connectedUsers.length,
      cardBuilder: (context, index) => Center(child: Obx(() {
        return Visibility(
          visible: true,
          //!_platformController.swipedUsers.contains(_platformController.connectedUsers[index].uid),
          child: UserPlatformCard(
            userName: _platformController.connectedUsers[index].name,
            userImageList:
                _platformController.connectedUsers[index].userImages.images,
            selectedImage: _platformController
                .connectedUsers[index].userImages.images[index].imageUrl,
            age: '1',
            bio: index.toString(),
          ),
        );
      })),
    );
  }

  Column buildUnconnectedToPlatform(BuildContext context) {
    return Column(
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
                QRModalBottomSheetUtility.buildQRScanBottomSheet(context);
              },
              child: const Text("CONNECT TO A PLATFORM")),
        )
      ],
    );
  }

  Column buildEmptyUserList() {
    return const Column(
      children: [Text("sorry")],
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
