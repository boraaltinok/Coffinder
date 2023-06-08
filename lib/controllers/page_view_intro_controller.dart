import 'package:get/get.dart';

class PageViewIntroController extends GetxController {
  final Rx<int> _selectedPageIndex = 0.obs;

  get selectedPageIndex => _selectedPageIndex.value;

  setSelectedPageIndex({required int pageIndex}) {
    _selectedPageIndex.value = pageIndex;
  }
}
