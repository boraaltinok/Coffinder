import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Utilities/DimensionsUtility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 8,
      child: Column(
        children: [
          CircleAvatar(
            radius: DimensionsUtility.radius30,
            backgroundImage: CachedNetworkImageProvider(
              "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
            ),
          ),
          Text('Bora',),
          Text('(Starbucks)')
        ],
      ),
    );
  }
}
