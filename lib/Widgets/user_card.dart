import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utilities/FontSizeUtility.dart';
import '../controllers/theme_controller.dart';

class UserCard extends StatelessWidget {
  UserCard({Key? key, this.isSmallCard = false}) : super(key: key){
    final random = Random();
    final randomIndex = random.nextInt(FakeData().images.length);
    selectedImage = FakeData().images[randomIndex];
  }
  final bool isSmallCard;

  late final String selectedImage; // Declare the selected image


  // generates a new Random object

  @override
  Widget build(BuildContext context) {
    // generate a random index based on the list length
// and use it to retrieve the element
    return Container(
      width: isSmallCard ? Get.height / 3 : 300,
      height: isSmallCard ? Get.height / 5 : 400,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.find<ThemeController>()
                    .appTheme
                    .colorScheme
                    .primaryContainer,
              ),
            );
          }),
          Positioned(
            top: isSmallCard ? 3 : 6,
            right: isSmallCard ? 3 : 6,
            left: isSmallCard ? 3 : 6,
            bottom: isSmallCard ? 30 : 130,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: selectedImage,
              ),
            ),
          ),
          Positioned(
            top: isSmallCard ? null : 270,
            left: 6,
            right: 6,
            bottom: isSmallCard ? 5 : 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                  'Foid, 24',
                  style: TextStyle(
                      fontSize: isSmallCard
                          ? FontSizeUtility.font20
                          : FontSizeUtility.font35),
                )),
                isSmallCard
                    ? SizedBox(
                        width: 0,
                        height: 0,
                      )
                    : Container(
                        child: Text(
                          "I love fitness and sucking cocks. Buy me coffe",
                          style: TextStyle(fontSize: FontSizeUtility.font20),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
