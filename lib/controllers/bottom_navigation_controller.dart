import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  final Rx<int> _currentTabIndex = 0.obs;

  int get currentTabIndex => _currentTabIndex.value;

  void setCurrentTabIndex({required int index}){
    _currentTabIndex.value = index;
  }
}