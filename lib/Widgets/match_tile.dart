import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Utilities/DimensionsUtility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/user.dart';
import '../Models/match.dart';

class MatchTile extends StatelessWidget {
  const MatchTile(
      {Key? key, required this.matchedUser, required this.locationName})
      : super(key: key);
  final User matchedUser;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 8,
      child: Column(
        children: [
          CircleAvatar(
            radius: DimensionsUtility.radius30,
            backgroundImage: CachedNetworkImageProvider(
                matchedUser.userImages.images[0].imageUrl),
          ),
          Text(
            matchedUser.name.toString(),
          ),
          Text(locationName)
        ],
      ),
    );
  }
}
