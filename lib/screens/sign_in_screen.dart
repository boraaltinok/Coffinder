import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import '../Utilities/FontSizeUtility.dart';
import '../Widgets/text_input_field.dart';
import '../themes/themes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double appBarActionsHeight = AppBar(
      actions: [
        // Add your additional actions here
        IconButton(
          icon: Icon(Get.find<ThemeController>().appTheme == lightTheme
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined),
          onPressed: () {
            Get.find<ThemeController>().setTheme(
              newThemeData: Get.find<ThemeController>().appTheme == lightTheme
                  ? darkTheme
                  : lightTheme,
            );
          },
        )
      ],
    ).preferredSize.height;

    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    final double availableHeight =
        screenHeight - (appBarHeight + statusBarHeight);
    return GetBuilder<ThemeController>(builder: (themeController) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          elevation: 0,
          backgroundColor:
          themeController.appTheme.colorScheme.primaryContainer,
          automaticallyImplyLeading: false,
          actions: [
               IconButton(
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
              )
          ],
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: (availableHeight) * 4 / 10,
                  color: themeController.appTheme.colorScheme.surface,
                ),
                Container(
                  height: (availableHeight) * 4 / 10,
                  decoration: BoxDecoration(
                      color:
                      themeController.appTheme.colorScheme.primaryContainer,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(80))),
                  child: Center(
                    child: Lottie.asset(
                      'animations/prepare_coffe_lottie.json',
                      height: availableHeight * 5 / 10 / 2,
                      reverse: true,
                      repeat: true,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.width,
                height: (availableHeight) * 6 / 10,
                color: Get.find<ThemeController>()
                    .appTheme
                    .colorScheme
                    .primaryContainer,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: loginContainer(availableHeight, themeController, context),
            )
          ],
        ),
      );
    });
  }

  Container loginContainer(double availableHeight,
      ThemeController themeController, BuildContext context) {
    return Container(
      width: Get.width,
      height: (availableHeight) * 6 / 10,
      decoration: BoxDecoration(
          color: themeController.appTheme.colorScheme.surface,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(80))),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: PaddingUtility.smallAllPadding,
              child: SizedBox(
                child: loginFieldsColumn(context, themeController),
              ),
            ),
          ),
          expandedEmptySpace(),
        ],
      ),
    );
  }

  Column loginFieldsColumn(
      BuildContext context, ThemeController themeController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        emailPhoneField(context),
        passwordField(context),
        loginButtonContainer(context, themeController),
        dontHaveAnAccountField(context, themeController),
        continueWithSocialsSection(),
        googleSignInContainer(context, themeController),
      ],
    );
  }

  Container googleSignInContainer(BuildContext context, ThemeController themeController) {
    return Container(
      width: MediaQuery.of(context).size.width - FontSizeUtility.font40,
      height: FontSizeUtility.font30 * 2,
      decoration: BoxDecoration(
          color: themeController.appTheme.colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 3)),
      child: InkWell(
          onTap: () {},
          child: SignInButton(
            Buttons.Google,
            text: "SIGN IN WITH GOOGLE",
            onPressed: () {
              //authController.signInWithGoogle();
            },
          )),
    );
  }

  Padding continueWithSocialsSection() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(children: [
        const Expanded(
            child: Divider(
              thickness: 2.00,
            )),
        Text(
          'or continue with social media',
          style: TextStyle(
            fontSize: FontSizeUtility.font15,
          ),
        ),
        const Expanded(
            child: Divider(
              thickness: 2.00,
            )),
      ]),
    );
  }

  Row dontHaveAnAccountField(BuildContext context, ThemeController themeController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
            child: Divider(
              thickness: 2.00,
            )),
        Text(
          "don\'t Have an Account?",
          style: TextStyle(
            fontSize: FontSizeUtility.font15,
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignUpScreen()));
            },
            child: Text(
              "Register",
              style: TextStyle(
                  fontSize: FontSizeUtility.font20,
                  color: themeController
                      .appTheme.colorScheme.onPrimaryContainer),
            )),
        const Expanded(
            child: Divider(
              thickness: 2.00,
            )),
      ],
    );
  }

  Container loginButtonContainer(BuildContext context, ThemeController themeController) {
    return Container(
      width: MediaQuery.of(context).size.width - FontSizeUtility.font40,
      height: FontSizeUtility.font30 * 2,
      decoration: BoxDecoration(
          color: themeController.appTheme.colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 3)),
      child: InkWell(
        onTap: () {},
        child: Center(
            child: Text(
              "login",
              style: TextStyle(
                  fontSize: FontSizeUtility.font20,
                  fontWeight: FontWeight.w700),
            )),
      ),
    );
  }

  SizedBox passwordField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextInputField(
        controller: TextEditingController(),
        labelText: "password",
        icon: Icons.password,
        isObscure: true,
      ),
    );
  }

  SizedBox emailPhoneField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextInputField(
        controller: TextEditingController(),
        labelText: "email or phone number",
        icon: Icons.email,
      ),
    );
  }

  Expanded expandedEmptySpace() => const Expanded(flex: 1, child: SizedBox());
}
