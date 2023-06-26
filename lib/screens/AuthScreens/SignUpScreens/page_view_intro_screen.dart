import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/controllers/page_view_intro_controller.dart';
import 'package:coffinder/screens/AuthScreens/SignInScreens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'sign_up_screen.dart';
import '../../../controllers/theme_controller.dart';
import '../../../themes/themes.dart';




class PageViewIntroScreen extends StatelessWidget {
  const PageViewIntroScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put(PageViewIntroController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
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
      body: Padding(
        padding: PaddingUtility.smallAllPadding,
        child: SizedBox(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  pageSnapping: true,
                  onPageChanged: ((index) {
                    Get.find<PageViewIntroController>()
                        .setSelectedPageIndex(pageIndex: index);
                  }),
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Lottie.asset(
                              'animations/coffee_shop_lottie.json',
                              height: 300,
                              reverse: true,
                              repeat: true,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  "Hello Simps!",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  "This is your golden opportunity to be a low t cuck. Enjoy the journey and buy some foid a coffee! Do not forget to buy the premium version of this app in order to prove your betabux skills. Now gtfo here! Remember, Coffee Connect is all about bringing people together through the love of coffee. So, grab your cup of joe, scan the QR code, and let the conversations flow.",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Lottie.asset(
                              'animations/coffee_time_lottie.json',
                              height: 300,
                              reverse: true,
                              repeat: true,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  "Join the Community",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  "Welcome to Coffee Connect, the app that connects coffee lovers like you! Discover new coffee shops, make new friends, and enjoy a delightful coffee experience. With Coffee Connect, you can break the ice and connect with fellow coffee enthusiasts right from your table. Let's explore how it works!",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Lottie.asset(
                              'animations/messaging_lottie.json',
                              height: 300,
                              reverse: true,
                              repeat: true,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  "Scan QR Codes for Coffee Shop Chats",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  "Scan the unique QR code available at your coffee shop table to join the chat group. Engage in conversations, share recommendations, or simply connect with other coffee lovers who are sipping their favorite brew. It's a great way to meet new people and make your coffee experience even more enjoyable.",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IndicatorsRow(),
                      TextButton(
                        child: Text("skip",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(decoration: TextDecoration.underline),),

                        onPressed: (){
                            Get.offAll(()=> const SignInScreen());
                        },
                        )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget IndicatorsRow() {
  return Obx(() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Get.find<PageViewIntroController>().selectedPageIndex == 0
            ? Icon(Icons.circle, size: 20)
            : Icon(
                Icons.circle_outlined,
                size: 20,
              ),
        Get.find<PageViewIntroController>().selectedPageIndex == 1
            ? Icon(Icons.circle, size: 20)
            : Icon(Icons.circle_outlined, size: 20),
        Get.find<PageViewIntroController>().selectedPageIndex == 2
            ? Icon(Icons.circle, size: 20)
            : Icon(Icons.circle_outlined, size: 20),
      ],
    );
  });
}
