import 'package:coffinder/Widgets/match_tile.dart';
import 'package:coffinder/Widgets/user_card.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/QRModalBottomSheetUtility.dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({Key? key}) : super(key: key);
  bool isConnected = true;
  var fakeMatches = FakeData().fakeMatches;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: isConnected
            ? GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4 / 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: fakeMatches.length,
            itemBuilder: (ctx, i) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(),
                  //color: Colors.red,
                  constraints: const BoxConstraints(
                      minHeight: 80, maxHeight: 500),
                  child: UserCard(isSmallCard: true,)
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
      ),
    );
  }
}
