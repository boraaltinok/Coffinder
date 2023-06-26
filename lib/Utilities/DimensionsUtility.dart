import 'package:get/get.dart';

class DimensionsUtility {
  static double screenHeight = Get.context!.height;//2400
  static double screenWidth = Get.context!.width;//1080

  static double galaxyA51HeightPixels = 915;
  static double galaxyA51WidthPixels = 412;


  static double height10 = screenHeight * (10 /galaxyA51HeightPixels );
  static double height12 = screenHeight * (12 /galaxyA51HeightPixels );
  static double height15 = screenHeight * (15 /galaxyA51HeightPixels );
  static double height20 = screenHeight * (20 /galaxyA51HeightPixels );
  static double height25 = screenHeight * (25 /galaxyA51HeightPixels );
  static double height30 = screenHeight * (30 /galaxyA51HeightPixels );
  static double height35 = screenHeight * (35 /galaxyA51HeightPixels );
  static double height40 = screenHeight * (40 /galaxyA51HeightPixels );

  static double radius10 = screenHeight * (10 / galaxyA51HeightPixels);
  static double radius15 = screenHeight * (15 / galaxyA51HeightPixels);
  static double radius20 = screenHeight * (20 / galaxyA51HeightPixels);
  static double radius25 = screenHeight * (25 / galaxyA51HeightPixels);
  static double radius30 = screenHeight * (30 / galaxyA51HeightPixels);
  static double radius35 = screenHeight * (35 / galaxyA51HeightPixels);


}