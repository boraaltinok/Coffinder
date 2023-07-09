import 'package:coffinder/Widgets/user_card.dart';
import 'package:coffinder/controllers/matches_controller.dart';
import 'package:coffinder/controllers/platform_controller.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/user.dart';
import '../../../Utilities/QRModalBottomSheetUtility.dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({Key? key}) : super(key: key);
  bool isConnected = true;
  //var fakeMatches = FakeData().fakeMatches;

  final MatchesController _matchesController = Get.find<MatchesController>();
  final PlatformController _platformController = Get.find<PlatformController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          return SizedBox(
            width: Get.width,
            child: _platformController.isConnectedToPlatform
                ? GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 4 / 5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemCount: _matchesController.matchedUsers.length,
                itemBuilder: (ctx, index) {
                  User matchedUser = _matchesController.matchedUsers[index];
                  return InkWell(
                    child: Container(
                      decoration: const BoxDecoration(),
                      //color: Colors.red,
                      constraints: const BoxConstraints(
                          minHeight: 80, maxHeight: 500),
                      child: UserCard(isSmallCard: true, userName: matchedUser.name.toString(), age: matchedUser.age.toString(), bio: "bio", selectedImage: matchedUser.userImages.images[0].imageUrl,)
                    ),
                    onTap: () {
                      print("ontap");
                    },
                  );
                })
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "All matches have timed out. Connect to a platform to see others!",
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
}
