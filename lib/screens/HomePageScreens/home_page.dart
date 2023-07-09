import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/bottom_navigation_controller.dart';
import 'package:coffinder/controllers/platform_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/controllers/user_controller.dart';
import 'package:coffinder/screens/HomePageScreens/HomePages_sub_Screens/chats_screen.dart';
import 'package:coffinder/screens/HomePageScreens/HomePages_sub_Screens/coffee_shop_screen.dart';
import 'package:coffinder/screens/HomePageScreens/HomePages_sub_Screens/matches_screen.dart';
import 'package:coffinder/screens/HomePageScreens/HomePages_sub_Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utilities/QRModalBottomSheetUtility.dart';
import '../../themes/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ThemeController _themeController;
  late PlatformController _platformController;
  late UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<BottomNavigationController>();
    _themeController = Get.find<ThemeController>();
    _platformController = Get.find<PlatformController>();
    _userController = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Coffinder"),
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: _themeController.appTheme.colorScheme.error,
            ),
            onPressed: () {
              authController.signOut();
            },
          ),
          actions: [
            Obx(() {
              return IconButton(
                icon: Icon(_themeController.appTheme == lightTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onPressed: () {
                  _themeController.setTheme(
                      newThemeData: _themeController.appTheme == lightTheme
                          ? darkTheme
                          : lightTheme);
                },
              );
            })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _platformController.setIsConnectedToPlatform(
                isConnected: !_platformController.isConnectedToPlatform);
            QRModalBottomSheetUtility.buildQRScanBottomSheet(context);
          },
          child: const Icon(
            Icons.qr_code_2_outlined,
            size: 40,
          ),
        ),
        body: Padding(
          padding: PaddingUtility.xSmallAllPadding,
          child: IndexedStack(
            index: Get.find<BottomNavigationController>().currentTabIndex,
            children: [
              CoffeeShopScreen(),
              ChatsScreen(),
              //MatchesScreen(),
              //ProfileScreen()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            Get.find<BottomNavigationController>()
                .setCurrentTabIndex(index: index);
            if (index == 2) {
              Get.find<UserController>().setHasNewMatches(
                  hasNewMessages: false, userId: authController.user.uid);
            }
          },
          currentIndex: Get.find<BottomNavigationController>().currentTabIndex,
          showSelectedLabels: true,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.coffee_outlined), label: "Coffe Shop"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined), label: "Chats"),
            BottomNavigationBarItem(
                icon: Obx(() {
                  return Stack(
                    children: [
                      _userController.hasNewMatches == true
                          ? Positioned(
                              top: 0,
                              left: 3,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _themeController
                                      .appTheme.colorScheme.primary,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const Icon(Icons.notification_add_outlined),
                    ],
                  );
                }),
                label: "Matches"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: "Profile"),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }
}
