import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/QRModalBottomSheetUtility.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: Column(
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
                    QRModalBottomSheetUtility.buildQRScanBottomSheet(context);
                  },
                  child: const Text("CONNECT TO A PLATFORM")),
            )
          ],
        ),
      ),
    );
  }
}
