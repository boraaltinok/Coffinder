import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/sign_up_process_controller.dart';
import 'package:coffinder/routing/app_routes.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/gender_selection_screen.dart';
import 'package:coffinder/screens/HomePageScreens/home_page.dart';
import 'package:coffinder/screens/AuthScreens/SignInScreens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lottie/lottie.dart';

import '../../../Utilities/FontSizeUtility.dart';
import '../../../Utilities/PaddingUtility.dart';
import '../../../Widgets/text_input_field.dart';
import '../../../controllers/theme_controller.dart';
import 'package:get/get.dart';

import '../../../themes/themes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

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
          automaticallyImplyLeading: true,
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
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: (availableHeight) * 2 / 10,
                  color: themeController.appTheme.colorScheme.surface,
                ),
                Container(
                  height: (availableHeight) * 2 / 10,
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
                height: (availableHeight) * 8 / 10,
                color: Get.find<ThemeController>()
                    .appTheme
                    .colorScheme
                    .primaryContainer,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: registerContainer(availableHeight, themeController, context),
            )
          ],
        ),
      );
    });
  }

  Container registerContainer(double availableHeight,
      ThemeController themeController, BuildContext context) {
    return Container(
      width: Get.width,
      height: (availableHeight) * 8 / 10,
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
                child: registerFieldsColumn(context, themeController),
              ),
            ),
          ),
          expandedEmptySpace(flexFactor: 1),
        ],
      ),
    );
  }

  Column registerFieldsColumn(
      BuildContext context, ThemeController themeController) {
    return Column(
      children: [
        expandedEmptySpace(flexFactor: 1),
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              emailPhoneField(context),
              userNameField(context),
              passwordField(context),
              registerButtonContainer(context, themeController),
              dontHaveAnAccountField(context, themeController),
            ],
          ),
        ),
        expandedEmptySpace(flexFactor: 1),
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
          "Already Have an Account? ",
          style: TextStyle(
            fontSize: FontSizeUtility.font15,
          ),
        ),
        InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.signIn);
            },
            child: Text(
              "Login",
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

  Container registerButtonContainer(BuildContext context, ThemeController themeController) {
    return Container(
      width: MediaQuery.of(context).size.width - FontSizeUtility.font40,
      height: FontSizeUtility.font30 * 2,
      decoration: BoxDecoration(
          color: themeController.appTheme.colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 3)),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.ageSelection);
          Get.find<SignUpProcessController>().setSignUpProcessInfo(email: _emailController.text, password: _passwordController.text, username: _userNameController.text);
        },
        child: Center(
            child: Text(
              "Register",
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
        controller: _passwordController,
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
        controller: _emailController,
        labelText: "email or phone number",
        icon: Icons.email,
      ),
    );
  }

  SizedBox userNameField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextInputField(
        controller: _userNameController,
        labelText: "Name and Surname",
        hintText: "John Pork",
        icon: Icons.person,
      ),
    );
  }

  Expanded expandedEmptySpace({required flexFactor}) =>  Expanded(flex: flexFactor, child: const SizedBox());
}
