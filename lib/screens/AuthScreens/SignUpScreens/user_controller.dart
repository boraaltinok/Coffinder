import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:get/get.dart';
import 'package:coffinder/models/user.dart' as userModel;

import '../../../Models/user_images.dart';


class UserController extends GetxController {

  RxList<UserImage> userImages = RxList<UserImage>([]);


  Future<void> fetchCurrentUserImages() async {
    try {
      String userId = authController.user.uid;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      userModel.User user = userModel.User.fromSnapshot(doc);
      userImages.value = user.userImages.images;
    } catch (e) {
      print('Error retrieving user images: $e');
      userImages.value = [];
    }
  }
}