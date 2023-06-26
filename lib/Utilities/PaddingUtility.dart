import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class PaddingUtility {
  static double screenHeight = Get.context!.height; //2400
  static double screenWidth = Get.context!.width; //1080

  static EdgeInsets xSmallAllPadding =
  EdgeInsets.fromLTRB(screenWidth * 1 / 10 / 4, screenHeight * 1 /20 / 4 , screenWidth * 1 / 10 / 4, screenHeight * 1 /20 / 4);

  static EdgeInsets smallAllPadding =
  EdgeInsets.fromLTRB(screenWidth * 1 / 10, screenHeight * 1 /20 , screenWidth * 1 / 10, screenHeight * 1 /20);
  static EdgeInsets mediumAllPadding =
  EdgeInsets.fromLTRB(screenWidth * 2 / 10, screenHeight * 2 /20, screenWidth * 2 / 10, screenHeight * 2 /20);
  static EdgeInsets largeAllPadding =
  EdgeInsets.fromLTRB(screenWidth * 3 / 10, screenHeight * 3 /20, screenWidth * 3 / 10, screenHeight * 3 /20);


  static EdgeInsets smallWidthOnlyPadding =
      EdgeInsets.fromLTRB(screenWidth * 1 / 10, 0, screenWidth * 1 / 10, 0);
  static EdgeInsets mediumWidthOnlyPadding =
      EdgeInsets.fromLTRB(screenWidth * 2 / 10, 0, screenWidth * 2 / 10, 0);
  static EdgeInsets largeWidthOnlyPadding =
      EdgeInsets.fromLTRB(screenWidth * 3 / 10, 0, screenWidth * 3 / 10, 0);

  static EdgeInsets xSmallHeightOnlyPadding =
  EdgeInsets.fromLTRB(0 ,screenHeight * 1 / 20 / 8, 0, screenHeight * 1 / 20 / 8);
  static EdgeInsets smallHeightOnlyPadding =
  EdgeInsets.fromLTRB(0 ,screenHeight * 1 / 20, 0, screenHeight * 1 / 20);
  static EdgeInsets mediumHeightOnlyPadding =
  EdgeInsets.fromLTRB(screenHeight * 2 / 20, 0, screenHeight * 2 / 20, 0);
  static EdgeInsets largeHeightOnlyPadding =
  EdgeInsets.fromLTRB(screenHeight * 3 / 20, 0, screenHeight * 3 / 20, 0);

  static EdgeInsets chatTilesTopBottomPadding = smallHeightOnlyPadding / 6;

  static EdgeInsets xSmallLeftOnlyPadding = EdgeInsets.only(left: screenWidth * 1 / 10 / 8);
}
