import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utilities/TextStyleUtility.dart';
import '../../../controllers/sign_up_process_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../routing/app_routes.dart';

class AgeSelectionScreen extends StatelessWidget {
  const AgeSelectionScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    SignUpProcessController signUpProcessController = Get.find<SignUpProcessController>();
    late DateTime? selectedDate = signUpProcessController.birthDate ?? DateTime(2000, 1, 1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Your Age"),
      ),
      floatingActionButton: Padding(
        padding: PaddingUtility.xSmallAllPadding,
        child: SizedBox(
          width: Get.width,
          child: ContinueFABButton(onTap: () {
            signUpProcessController.setSignUpProcessInfo(birthDate: selectedDate);
            Get.toNamed(AppRoutes.genderSelection);
          } ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: PaddingUtility.smallAllPadding,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "My birthday is",
                    style: TextStyleUtility.bigHeaderTextStyle,
                  )),
              Expanded(
                flex: 5,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: signUpProcessController.birthDate,
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedDate = newDateTime;
                  },
                ),
              ),
              Expanded(flex: 4, child: SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}

class ContinueFABButton extends StatelessWidget {
  ContinueFABButton({super.key, required this.onTap});

  final VoidCallback onTap;

  final SignUpProcessController _signUpProcessController =
      Get.find<SignUpProcessController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FloatingActionButton(
        onPressed: onTap,
        elevation: _signUpProcessController.birthDate == null ? 0 : 5,
        backgroundColor: _signUpProcessController.birthDate == null
            ? Get.find<ThemeController>()
                .appTheme
                .colorScheme
                .surfaceVariant
                .withOpacity(0.5)
            : Get.find<ThemeController>().appTheme.colorScheme.primary,
        child: Text(
          "Continue",
          style: _signUpProcessController.birthDate == null
              ? TextStyleUtility.mediumOpaqueHeaderTextStyle
              : TextStyleUtility.mediumHeaderTextStyle,
        ),
      );
    });
  }
}
