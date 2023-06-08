import 'package:coffinder/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utilities/FontSizeUtility.dart';
import '../Utilities/PaddingUtility.dart';

class ChatTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String locationName;
  final Image? image;
  final DateTime? date;
  final int? count;
  final Icon? icon;
  final VoidCallback? onTap;
  final Function? onImageTap;

  const ChatTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locationName,
    this.image,
    this.date,
    this.count,
    this.icon,
    this.onTap,
    this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: PaddingUtility.chatTilesTopBottomPadding,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: PaddingUtility.xSmallLeftOnlyPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: title,
                                  style: TextStyle(
                                    fontSize: FontSizeUtility.font20,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' (from $locationName)',
                                  style: TextStyle(
                                    fontSize: FontSizeUtility.font12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            subtitle,
                            style: TextStyle(fontSize: FontSizeUtility.font15, overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '18.00',
                          style: TextStyle(
                              fontSize: FontSizeUtility.font10,
                              color: Get.find<ThemeController>()
                                  .appTheme
                                  .colorScheme
                                  .error),
                        ),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Get.find<ThemeController>()
                              .appTheme
                              .colorScheme
                              .error,
                          child: Text('3',
                              style: TextStyle(fontSize: FontSizeUtility.font12)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chevron_right,
                          color: Get.find<ThemeController>()
                              .appTheme
                              .colorScheme
                              .outline,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
