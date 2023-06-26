import 'dart:io';

import 'package:coffinder/Utilities/FontSizeUtility.dart';
import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Utilities/SnackBarUtility.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/sign_up_process_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Utilities/TextStyleUtility.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<SignUpProcessController>().isEmailVerified == null ||
        Get.find<SignUpProcessController>().isEmailVerified == false) {
      Get.find<SignUpProcessController>().sendSMS();
        Get.find<SignUpProcessController>().smsVerificationTimer.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Email"),
      ),
      body: Padding(
        padding: PaddingUtility.smallAllPadding,
        child: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "We have sent a verification email to ${Get.find<SignUpProcessController>().email} Please click on the verification link in the email.",
                textAlign: TextAlign.center,
                style: TextStyleUtility.mediumHeaderTextStyle,
              ),
              Lottie.asset(
                'animations/email_verification_lottie.json',
                height: 300,
                reverse: true,
                repeat: true,
              ),
              Container(width: Get.width, child: buildSMSVerificationButton()),
              ElevatedButton(
                  onPressed: () {
                    Get.offAll(HomePage());
                  },
                  child: const Text("FINISHED TEST"))
            ],
          ),
        ),
      ),
    );
  }

  Obx buildSMSVerificationButton() {
    SignUpProcessController _signUpProcessController =
        Get.put(SignUpProcessController());
    return Obx(() {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _signUpProcessController.readyToSendAgain
                ? Get.find<ThemeController>().appTheme.colorScheme.primary
                : Get.find<ThemeController>()
                    .appTheme
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.5),
          ),
          onPressed: () {
            if (_signUpProcessController.readyToSendAgain == false) {
              SnackBarUtility.showCustomSnackbar(
                  title: "Verification",
                  message: "Wait a few seconds before resending",
                  icon: const Icon(Icons.email_outlined));
            } else {
              _signUpProcessController.sendSMS();
            }
            //Get.to(AgeSelectionScreen());
          },
          child: Text(
            "Resend the verification email",
            textAlign: TextAlign.center,
            style: _signUpProcessController.readyToSendAgain
                ? TextStyleUtility.mediumHeaderTextStyle.copyWith(
                    color: Get.find<ThemeController>()
                        .appTheme
                        .colorScheme
                        .onPrimaryContainer)
                : TextStyleUtility.mediumOpaqueHeaderTextStyle,
          ));
    });
  }
}
