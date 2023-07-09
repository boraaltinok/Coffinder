import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Models/user_images.dart';
import 'package:coffinder/Utilities/RadiusUtility.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:coffinder/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final TextEditingController _bioController = TextEditingController(
    text: "18 years young 18cm hung, fresh out of prison. XOX",
  );

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final textLength = _bioController.text.length;
      _bioController.selection = TextSelection(
        baseOffset: textLength,
        extentOffset: textLength,
      );
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 4 / 10,
                width: Get.width,
                child: Obx(() {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                userController.userImages.isNotEmpty
                                    ? userController.userImages[0].imageUrl
                                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Jeremy_Meeks_Mug_Shot.jpg/640px-Jeremy_Meeks_Mug_Shot.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            color: Get.find<ThemeController>()
                                .appTheme
                                .colorScheme
                                .surfaceVariant,
                            borderRadius:
                                RadiusUtility.smallBorderCircularRadius),
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_a_photo_outlined,
                                size: 35,
                              ))),
                      Positioned(
                          top: 45,
                          right: 5,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 35,
                              ))),
                    ],
                  );
                }),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Bigoraphy:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _bioController,
                        keyboardType: TextInputType.multiline,
                        //maxLines: 10,
                        autofocus: false,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "Add your bio here",
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
