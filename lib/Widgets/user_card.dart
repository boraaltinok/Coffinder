import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Utilities/RadiusUtility.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utilities/FontSizeUtility.dart';
import '../controllers/theme_controller.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    this.isSmallCard = false,
    required this.userName,
    required this.age,
    required this.bio,
    required this.selectedImage, // Accept selectedImage parameter
  }) : super(key: key);

  final bool isSmallCard;
  final String userName;
  final String age;
  final String bio;
  final String selectedImage; // Declare the selected image

  // generates a new Random object

  @override
  Widget build(BuildContext context) {
    // generate a random index based on the list length
// and use it to retrieve the element
    return Container(
      width: isSmallCard ? Get.height / 3 : Get.width,
      height: isSmallCard ? Get.height / 5 : Get.height,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: RadiusUtility.smallBorderCircularRadius),
      child: Stack(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: RadiusUtility.smallBorderCircularRadius,
                color: Get.find<ThemeController>()
                    .appTheme
                    .colorScheme
                    .primaryContainer,
              ),
            );
          }),
          Positioned.fill(
            top: isSmallCard ? 3 : 0,
            right: isSmallCard ? 3 : 0,
            left: isSmallCard ? 3 : 0,
            bottom: isSmallCard ? 30 : 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: RadiusUtility.smallCircularRadius,
                  topRight: RadiusUtility.smallCircularRadius),
              child: selectedImage.isNotEmpty
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: selectedImage,
                    )
                  : null,
            ),
          ),
          Positioned(
            top: isSmallCard ? null : null,
            left: 6,
            right: 6,
            bottom: isSmallCard ? 5 : 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                  '${userName}, ${age}',
                  style: TextStyle(
                      fontSize: isSmallCard
                          ? FontSizeUtility.font20
                          : FontSizeUtility.font35).copyWith(color: Get.find<ThemeController>().appTheme.colorScheme.surface, fontWeight: FontWeight.bold),
                )),
                isSmallCard
                    ? const SizedBox(
                        width: 0,
                        height: 0,
                      )
                    : Text(
                        bio + "Hey. I am from Bilkent University. I love eating in Bilka! hit me upppppppppp ",
                        style: TextStyle(fontSize: FontSizeUtility.font20).copyWith(color: Get.find<ThemeController>().appTheme.colorScheme.surface),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
