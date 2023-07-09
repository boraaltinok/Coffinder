import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:coffinder/models/user.dart' as userModel;

import '../Models/user_images.dart';

class UserController extends GetxController {
  final RxList<UserImage> _userImages = <UserImage>[].obs;

  final Rx<bool> _hasNewMatches = Rx<bool>(false);

  bool get hasNewMatches => _hasNewMatches.value;

  List<UserImage> get userImages => _userImages.value;

  late StreamSubscription<User?>? _authSubscription;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _subscribeToAuthChanges();
  }
  Future<void> _subscribeToAuthChanges() async {

    _authSubscription = firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is logged in, bind the data
        print("binding to new user with id ${user.uid} }");
        _bindUserImages(userId: user.uid);
        _bindHasNewMatches(userId: user.uid);
      } else {
        // User is logged out, clear the data
        print("binding currentUser ${user?.uid} ");

        _userImages.clear();
      }
    });
  }


  void _bindHasNewMatches({required String userId}) {

    _hasNewMatches.bindStream(firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.data()?['hasNewMatches'] ?? false;
    }));
  }

  void _bindUserImages({required String userId}) {
    _userImages.value = [];
    print("userId is $userId");
    _userImages.bindStream(firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      final userData = snapshot.data();
      print("triggered with userId ${userId}");
      if (userData != null) {
        final userImagesData = userData['userImages']['images'] as List<dynamic>;
        if (userImagesData != null) {
          final userImages = userImagesData
              .map((imageData) => UserImage.fromJson(imageData))
              .toList();
          print("here123 ${userImages}");

          return userImages;
        }
      }

      return <UserImage>[];
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
        _userImages.value = user.userImages.images;

        print("usercontroller fetching ${user.userImages.images}");
      }
    } catch (e) {
      print('Error retrieving user images: $e');
      _userImages.value = [];
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
