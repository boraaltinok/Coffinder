import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffinder/Utilities/RadiusUtility.dart';
import 'package:coffinder/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/user_images.dart';
import '../Utilities/FontSizeUtility.dart';
import '../controllers/theme_controller.dart';
import 'line_indicators_row.dart';

class UserPlatformCard extends StatefulWidget {
  const UserPlatformCard({
    Key? key,
    required this.userName,
    required this.age,
    required this.bio,
    required this.selectedImage,
    required this.userImageList,
  }) : super(key: key);

  final String userName;
  final List<UserImage> userImageList;
  final String age;
  final String bio;
  final String selectedImage;

  @override
  State<UserPlatformCard> createState() => _UserPlatformCardState();
}

class _UserPlatformCardState extends State<UserPlatformCard> {
  late int currentIndex;
  late ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _themeController = Get.find<ThemeController>();
  }

  void changePageIndex(bool increment) {
    setState(() {
      if (increment) {
        currentIndex = (currentIndex + 1) % widget.userImageList.length;
      } else {
        currentIndex = (currentIndex - 1 + widget.userImageList.length) %
            widget.userImageList.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildGestureDetector(context),
        Positioned(
          top: 6,
          left: 0,
          right: 0,
          child: LineIndicatorsRow(
            itemCount: widget.userImageList.length,
            currentIndex: currentIndex,
          ),
        ),
      ],
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        final tapPosition = details.localPosition;
        final cardWidth = MediaQuery.of(context).size.width;
        final tapAreaWidth = cardWidth / 2.0;

        if (tapPosition.dx >= tapAreaWidth) {
          changePageIndex(true); // Increment currentIndex
        } else {
          changePageIndex(false); // Decrement currentIndex
        }
      },
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: RadiusUtility.smallBorderCircularRadius,
        ),
        child: buildUserImagesPageView(),
      ),
    );
  }

  PageView buildUserImagesPageView() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.userImageList.length,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return Stack(
          children: [
            buildObxStackBackground(),
            Positioned.fill(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: buildClipRRectUserImage(),
            ),
            Positioned(
              top: null,
              left: 6,
              right: 6,
              bottom: 10,
              child: buildCardTextSection(),
            ),
          ],
        );
      },
    );
  }

  Column buildCardTextSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.userName}, ${widget.age}',
          style: TextStyle(fontSize: FontSizeUtility.font35).copyWith(
              color: Get.find<ThemeController>().appTheme.colorScheme.surface,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "${widget.bio}Hey. I am from Bilkent University. I love eating in Bilka! hit me upppppppppp ",
          style: TextStyle(fontSize: FontSizeUtility.font20).copyWith(
              color: Get.find<ThemeController>().appTheme.colorScheme.surface),
        ),
      ],
    );
  }

  ClipRRect buildClipRRectUserImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: RadiusUtility.smallCircularRadius,
        topRight: RadiusUtility.smallCircularRadius,
      ),
      child: widget.selectedImage.isNotEmpty
          ? CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.userImageList[currentIndex].imageUrl,
            )
          : null,
    );
  }

  Obx buildObxStackBackground() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: RadiusUtility.smallBorderCircularRadius,
          color:
              Get.find<ThemeController>().appTheme.colorScheme.primaryContainer,
        ),
      );
    });
  }
}
