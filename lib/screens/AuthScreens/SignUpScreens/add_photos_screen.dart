import 'package:coffinder/Utilities/PaddingUtility.dart';
import 'package:coffinder/Widgets/picture_card.dart';
import 'package:coffinder/Widgets/user_card.dart';
import 'package:coffinder/controllers/image_picker_controller.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utilities/SnackBarUtility.dart';
import '../../../Utilities/TextStyleUtility.dart';
import '../../../routing/app_routes.dart';
import '../../../themes/themes.dart';

class AddPhotosScreen extends StatelessWidget {
  const AddPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: PaddingUtility.xSmallAllPadding,
        child: SizedBox(
          width: Get.width,
          child: _ContinueFABButton(onTap: (){
            if (Get.find<ImagePickerController>().selectedImageCount < 2) {
              SnackBarUtility.showCustomSnackbar(
                title: "Photos",
                message: "Please add at least 2 photo",
                icon: const Icon(Icons.account_circle_outlined),
              );
            } else {
              // Iterate over each selected image and add it to Firestore
              Get.find<ImagePickerController>().uploadSelectedImages();
              SnackBarUtility.showCustomSnackbar(title: 'Success', message: 'Account Created', icon:  Icon(Icons.check_circle_outline));
              Get.offAllNamed(AppRoutes.home);

            }
          }),
        ),
      ),
      body: Padding(
        padding: PaddingUtility.xSmallAllPadding,
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      'Add Photos',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Get.find<ThemeController>()
                              .appTheme
                              .colorScheme
                              .primary),
                    ),
                    Text(
                      'Add at least 2 photos to continue',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Get.find<ThemeController>()
                                  .appTheme
                                  .colorScheme
                                  .secondary),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 4 / 5,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: 6,
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        child: Container(
                          decoration: BoxDecoration(),
                          //color: Colors.red,
                          constraints: const BoxConstraints(
                              minHeight: 80, maxHeight: 500),
                          child: PictureCard(isSmallCard: true, position: i),
                        ),
                        onTap: () {},
                        onLongPress: () {},
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueFABButton extends StatelessWidget {
  _ContinueFABButton({super.key, required this.onTap});

  final VoidCallback onTap;

  final ImagePickerController _imagePickerController =
  Get.find<ImagePickerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FloatingActionButton(
        onPressed: onTap,
        elevation: _imagePickerController.selectedImageCount <2 ?  0 : 5,
        backgroundColor: _imagePickerController.selectedImageCount <2
            ? Get.find<ThemeController>()
            .appTheme
            .colorScheme
            .surfaceVariant
            .withOpacity(0.5)
            : Get.find<ThemeController>().appTheme.colorScheme.primary,
        child: Text(
          "Continue",
          style: _imagePickerController.selectedImageCount <2
              ? TextStyleUtility.mediumOpaqueHeaderTextStyle
              : TextStyleUtility.mediumHeaderTextStyle,
        ),
      );
    });
  }
}

