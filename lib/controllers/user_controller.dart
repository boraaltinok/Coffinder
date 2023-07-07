import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:get/get.dart';
import 'package:coffinder/models/user.dart' as userModel;

import '../Models/user_images.dart';

class UserController extends GetxController {
  RxList<UserImage> userImages = RxList<UserImage>([]);

  final Rx<bool> _hasNewMatches = Rx<bool>(false);

  bool get hasNewMatches => _hasNewMatches.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _bindHasNewMatches();
  }

  void _bindHasNewMatches() {
    _hasNewMatches.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.data()?['hasNewMatches'] ?? false;
    }));
  }

  Future<void> fetchCurrentUserImages() async {
    try {
      print("fetch before ${authController}");

      String? userId = firebaseAuth.currentUser?.uid;
      if (userId != null) {
        print("fetch userId ${userId}");
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        userModel.User user = userModel.User.fromSnapshot(doc);
        userImages.value = user.userImages.images;

        print("usercontroller fetching ${user.userImages.images}");
      }
    } catch (e) {
      print('Error retrieving user images: $e');
      userImages.value = [];
    }
  }

  Future<void> setHasNewMatches(
      {required bool hasNewMessages, required String userId}) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .update({'hasNewMatches': hasNewMessages});
      _hasNewMatches.value = hasNewMessages;
    } catch (e) {
      print("error setting hasNewMessages $e");
    }
  }
}
