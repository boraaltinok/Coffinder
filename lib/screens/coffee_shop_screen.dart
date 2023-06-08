import 'package:coffinder/Utilities/QRModalBottomSheetUtility.dart';
import 'package:coffinder/screens/barcode_scan_page.dart';
import 'package:coffinder/screens/platform_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoffeeShopScreen extends StatelessWidget {
  CoffeeShopScreen({Key? key}) : super(key: key);

  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: isConnected == true
            ? PlatformScreen()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Currently Not Connected to a Platform"),
                  Container(
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
