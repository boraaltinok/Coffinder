import 'package:coffinder/Enums/GenderTypeEnum.dart';
import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Utilities/SnackBarUtility.dart';
import 'package:coffinder/Utilities/TextStyleUtility.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/sign_up_process_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/routing/app_routes.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/age_selection_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/email_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({Key? key}) : super(key: key);

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  late SignUpProcessController _signUpProcessController;

  @override
  void initState() {
    // TODO: implement initState
    _signUpProcessController = Get.find<SignUpProcessController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Your Gender"),
      ),
      floatingActionButton: Padding(
        padding: PaddingUtility.xSmallAllPadding,
        child: SizedBox(
          width: Get.width,
          child: buildContinueFAButton(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: PaddingUtility.smallAllPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "I am a",
                  style: TextStyleUtility.bigHeaderTextStyle,
                )),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: PaddingUtility.xSmallHeightOnlyPadding,
                      child: SizedBox(
                          width: Get.width,
                          child: buildGenderButton(genderEnum: GenderEnum.Man)),
                    ),
                    Padding(
                      padding: PaddingUtility.xSmallHeightOnlyPadding,
                      child: SizedBox(
                          width: Get.width,
                          child:
                              buildGenderButton(genderEnum: GenderEnum.Woman)),
                    ),
                    Padding(
                      padding: PaddingUtility.xSmallHeightOnlyPadding,
                      child: SizedBox(
                          width: Get.width,
                          child: buildGenderButton(
                              genderEnum: GenderEnum.DontWantToMention)),
                    ),
                  ],
                )),
            Expanded(flex: 4, child: SizedBox()),
          ],
        ),
      ),
    );
  }

  buildContinueFAButton() {
    return _ContinueFABButton(
      onTap: () {
        if (_signUpProcessController.gender == null) {
          SnackBarUtility.showCustomSnackbar(
            title: "Gender",
            message: "Please select a gender",
            icon: Icon(Icons.account_circle_outlined),
          );
        } else {
          _signUpProcessController.setSignUpProcessInfo(
              genderEnum: _signUpProcessController.gender);
          authController.registerUser(
              username: _signUpProcessController.username,
              email: _signUpProcessController.email,
              password: _signUpProcessController.password,
              verifyPassword: _signUpProcessController.password,
              country: "country",
              gender: _signUpProcessController.gender.toString());
          Get.toNamed(AppRoutes.emailVerification);
        }
      },
    );
  }

  Obx buildGenderButton({required GenderEnum genderEnum}) {
    return Obx(() {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _signUpProcessController.gender == genderEnum
                ? ThemeController().appTheme.colorScheme.primary
                : null,
          ),
          onPressed: () {
            _signUpProcessController.setGender(gender: genderEnum);
          },
          child: Text(
            genderEnum.value.toString(),
            style: _signUpProcessController.gender == genderEnum
                ? TextStyleUtility.mediumHeaderTextStyle.copyWith(
                    color: Get.find<ThemeController>()
                        .appTheme
                        .colorScheme
                        .onPrimaryContainer)
                : TextStyleUtility.mediumHeaderTextStyle,
          ));
    });
  }
}

class _ContinueFABButton extends StatelessWidget {
  _ContinueFABButton({super.key, required this.onTap});

  final VoidCallback onTap;

  final SignUpProcessController _signUpProcessController =
      Get.find<SignUpProcessController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FloatingActionButton(
        onPressed: onTap,
        elevation: _signUpProcessController.gender == null ? 0 : 5,
        backgroundColor: _signUpProcessController.gender == null
            ? Get.find<ThemeController>()
                .appTheme
                .colorScheme
                .surfaceVariant
                .withOpacity(0.5)
            : Get.find<ThemeController>().appTheme.colorScheme.primary,
        child: Text(
          "Continue",
          style: _signUpProcessController.gender == null
              ? TextStyleUtility.mediumOpaqueHeaderTextStyle
              : TextStyleUtility.mediumHeaderTextStyle,
        ),
      );
    });
  }
}
