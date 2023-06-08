import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '';class DenemeScreen extends StatelessWidget {
  const DenemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
      ),
      body: Container(
        height: Get.height -80,
        width: Get.width,
        color: Colors.red,
        child: Column(
          children: [
            Container(
              height: (Get.height -80 - MediaQuery.of(context).viewPadding.top
      )/2,
              width: Get.width,
              color: Colors.blue,
            ),
            Container(
              height: (Get.height -80 - MediaQuery.of(context).viewPadding.top
              )/2,              width: Get.width,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
