import 'package:coffinder/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utilities/FontSizeUtility.dart';

class SelectAuthMethodButton extends StatelessWidget {
  SelectAuthMethodButton({
    required this.buttonText,
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;
  final String buttonText;

  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - FontSizeUtility.font40,
      height: FontSizeUtility.font30 * 2,
      decoration: BoxDecoration(
          color: _themeController.appTheme.colorScheme.tertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 3)),
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: Text(
              buttonText,
          style: TextStyle(
              fontSize: FontSizeUtility.font20, fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}
