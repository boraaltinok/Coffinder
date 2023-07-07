import 'package:flutter/material.dart';

import '../controllers/theme_controller.dart';
import 'package:get/get.dart';

class LineIndicatorsRow extends StatelessWidget {
  const LineIndicatorsRow({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    print("building indicators");
    ThemeController themeController = Get.find<ThemeController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < itemCount; i++)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: currentIndex == i
                    ? themeController.appTheme.colorScheme.primaryContainer
                    : themeController.appTheme.colorScheme.outline,
                boxShadow: currentIndex == i
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
      ],
    );
  }
}
