import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/controllers/bottom_navigation_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/screens/chats_screen.dart';
import 'package:coffinder/screens/coffee_shop_screen.dart';
import 'package:coffinder/screens/matches_screen.dart';
import 'package:coffinder/screens/messages_screen.dart';
import 'package:coffinder/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/QRModalBottomSheetUtility.dart';
import '../themes/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(BottomNavigationController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Coffinder"),
          actions: [
            Obx(() {
              return IconButton(
                icon: Icon(Get.find<ThemeController>().appTheme == lightTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onPressed: () {
                  Get.find<ThemeController>().setTheme(
                      newThemeData:
                          Get.find<ThemeController>().appTheme == lightTheme
                              ? darkTheme
                              : lightTheme);
                },
              );
            })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            QRModalBottomSheetUtility.buildQRScanBottomSheet(context);
          },
          child: const Icon(
            Icons.qr_code_2_outlined,
            size: 40,
          ),
        ),
        body: Padding(
          padding: PaddingUtility.xSmallAllPadding,
          child: Container(
            child: IndexedStack(
              index: Get.find<BottomNavigationController>().currentTabIndex,
              children: [
                CoffeeShopScreen(),
                ChatsScreen(),
                MatchesScreen(),
                ProfileScreen()
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            Get.find<BottomNavigationController>()
                .setCurrentTabIndex(index: index);
          },
          currentIndex: Get.find<BottomNavigationController>().currentTabIndex,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.coffee_outlined), label: "Coffe Shop"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: "Chats"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add_outlined), label: "Matches"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: "Profile"),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }
}
