import 'package:coffinder/controllers/chat_controller.dart';
import 'package:coffinder/controllers/location_controller.dart';
import 'package:coffinder/controllers/matches_controller.dart';
import 'package:coffinder/controllers/messages_controller.dart';
import 'package:coffinder/controllers/platform_controller.dart';
import 'package:coffinder/controllers/sign_up_process_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/fake_data.dart';
import 'package:coffinder/routing/app_routes.dart';
import 'package:coffinder/controllers/user_controller.dart';
import 'package:coffinder/screens/home_page.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/page_view_intro_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/sign_up_screen.dart';
import 'package:coffinder/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/bottom_navigation_controller.dart';
import 'controllers/image_picker_controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    Get.put(ThemeController());
    Get.put(AuthController());
    Get.find<AuthController>();
    Get.put(UserController());
    Get.put(SignUpProcessController());
    Get.put(ImagePickerController());
    Get.put(PlatformController());
    Get.put(BottomNavigationController());
    Get.put(MatchesController());
    Get.put(ChatController());
    Get.put(MessagesController());
    Get.put(LocationController());


    //FakeData().addFakeLocationToFirestore();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: Get.find<ThemeController>().appTheme,
        getPages: AppRoutes.routes,
      );
    });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Update with your UI',
              ),
              TextButton(
                  onPressed: () {
                    Get.find<ThemeController>()
                        .setTheme(newThemeData: darkTheme);
                  },
                  child: Text("switch theme")),
              TextButton(
                  onPressed: () {
                    Get.find<ThemeController>()
                        .setTheme(newThemeData: lightTheme);
                  },
                  child: Text("switch theme")),
              TextButton(
                  onPressed: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: Text("go to sign up page")),
              TextButton(
                  onPressed: () {
                    Get.to(() => const PageViewIntroScreen());
                  },
                  child: Text("go to sign up page"))
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => {}, tooltip: 'Increment'));
  }
}
