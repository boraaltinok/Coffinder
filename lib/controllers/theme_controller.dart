import 'package:coffinder/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<ThemeData> _appTheme = lightTheme.obs;

  get appTheme => _appTheme.value;


  setTheme({required ThemeData newThemeData}){
    _appTheme.value = newThemeData;
    update();
  }
}