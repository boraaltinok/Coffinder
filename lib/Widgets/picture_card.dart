import 'dart:math';
import 'package:coffinder/controllers/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/theme_controller.dart';
import '../fake_data.dart';

class PictureCard extends StatelessWidget {
  PictureCard({Key? key, this.isSmallCard = false, required this.position})
      : super(key: key) {
    final random = Random();
    final randomIndex = random.nextInt(FakeData().images.length);
  }

  final bool isSmallCard;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: isSmallCard ? Get.height / 3 : 300,
        height: isSmallCard ? Get.height / 5 : 400,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.find<ThemeController>()
                    .appTheme
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),
            Positioned(
                top: isSmallCard ? 3 : 6,
                right: isSmallCard ? 3 : 6,
                left: isSmallCard ? 3 : 6,
                bottom: isSmallCard ? 3 : 130,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Get.find<ImagePickerController>()
                                .selectedImages[position] ==
                            null
                        ? null
                        : Image(
                            image: Image.file(Get.find<ImagePickerController>()
                                    .selectedImages[position]!)
                                .image,
                            fit: BoxFit.cover,
                          ))),
            Positioned(
                bottom: 5,
                right: 0,
                child: CircleAvatar(
                  radius: 15,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 15,
                    ),
                    onPressed: () {
                      Get.find<ImagePickerController>().pickImageToPosition(
                          source: ImageSource.gallery, position: position);
                    },
                  ),
                ))
          ],
        ),
      );
    });
  }
}
