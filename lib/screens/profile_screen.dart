import 'package:coffinder/Widgets/text_input_field.dart';
import 'package:coffinder/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Get.find<ThemeController>()
                              .appTheme
                              .colorScheme
                              .surfaceVariant,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_a_photo_outlined,
                              size: 35,
                            ))),
                    Positioned(
                        top: 45,
                        right: 5,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 35,
                            )))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Bigoraphy:", style: TextStyle(fontWeight: FontWeight.bold),),
                        TextField(
                          controller:
                          TextEditingController(),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
