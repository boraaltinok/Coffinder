import 'package:coffinder/Enums/SwipeTypeEnum.dart';
import 'package:coffinder/Models/match.dart';
import 'package:coffinder/Models/swipe.dart';
import 'package:coffinder/Utilities/RandomIdGenerator.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/user.dart' as userModel; // Import your existing User model
import 'package:firebase_auth/firebase_auth.dart';

class PlatformController extends GetxController {
  final RxList<userModel.User> _connectedUsers = <userModel.User>[].obs;
  final RxList<String> _swipedUsers = <String>[].obs;
  final Rx<bool> _isConnectedToPlatform = Rx<bool>(false);

  List<userModel.User> get connectedUsers => _connectedUsers.value;

  List<String> get swipedUsers => _swipedUsers.value;

  bool get isConnectedToPlatform => _isConnectedToPlatform.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _subscribeToAuthChanges();
  }

  Future<void> _subscribeToAuthChanges() async {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is logged in, bind the data
        _bindConnectedUsers(userId: user.uid);
        _bindSwipedUsers(userId: user.uid);
      } else {
        // User is logged out, clear the data
        print("binding currentUser ${user?.uid} ");

        _swipedUsers.clear();
      }
    });
  }

  /// Binds the connected users to the platform controller by retrieving their
  /// user documents from the 'connected_users' collection in the specified location.
  /// The retrieved user documents are used to populate the [_connectedUsers] list.
  void _bindConnectedUsers({required String userId}) {
    _connectedUsers.bindStream(firestore
        .collection('locations')
        .doc('Starbucks')
        .collection('connected_users')
        .snapshots()
        .asyncMap((QuerySnapshot query) async {
      List<String> connectedUserIds = query.docs.map((doc) => doc.id).toList();
      List<userModel.User> connectedUsers = [];
      print("connectedUserIds.length ${connectedUserIds.length}");

      for (String userId in connectedUserIds) {
        print("FOUND A USER WOTH ID $userId");
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          print("AND FOUND USER EXISTS!");
          userModel.User user = userModel.User.fromSnapshot(userDoc);
          connectedUsers.add(user);
        }
      }
      return connectedUsers;
    }));
  }

  void _bindSwipedUsers({required String userId}) {
    _swipedUsers.bindStream(firestore
        .collection('locations')
        .doc('Starbucks')
        .collection('connected_users')
        .doc(userId)
        .collection('swipes')
        .snapshots()
        .map((QuerySnapshot query) {
      if (query.docs.isEmpty) {
        // Handle empty snapshot here
        print("CURRENTLY SWIPES ARE EMPTY");
        return [];
      } else {
        List<String> swipedUserIds = query.docs.map((doc) => doc.id).toList();
        for (String swipedUserId in swipedUserIds) {
          print("FOUND A SWIPE $swipedUserId");
        }
        return swipedUserIds;
      }
    }));
  }

  Future<bool> handleSwipe(
      {required SwipeTypeEnum swipeTypeEnum,
      required String swipedUserId}) async {
    bool isMatched = false;
    try {
      userModel.User? currentUser =
          await authController.getUser(userId: authController.user.uid);
      Swipe swipe = Swipe(
          swipeId: 'error',
          swiperId: 'error',
          swipedUserId: 'error',
          locationId: 'error',
          swipeDirection: swipeTypeEnum);
      final String randomId = RandomIdGenerator.generateUniqueId();
      if (currentUser != null) {
        swipe = Swipe(
            swipeId: randomId,
            swiperId: authController.user.uid,
            swipedUserId: swipedUserId,
            locationId: currentUser.locationId ?? 'ERROR',
            swipeDirection: swipeTypeEnum);
      }
      await FirebaseFirestore.instance
          .collection('locations')
          .doc(currentUser?.locationId)
          .collection('connected_users')
          .doc(authController.user.uid)
          .collection('swipes')
          .doc(swipedUserId)
          .set(swipe.toJson());
      if (swipeTypeEnum == SwipeTypeEnum.right) {
        isMatched = await _checkIfMatched(
            locationId: currentUser?.locationId ?? 'deafult',
            swipedUserId: swipedUserId);
      }
    } catch (e) {
      print('Failed to swipe : $e');
    }
    return isMatched;
  }

  //ONLY CHECK WHEN A USERS SWIPES RIGHT.
  Future<bool> _checkIfMatched(
      {required String swipedUserId, required String locationId}) async {
    try {
      // Check if the swiped user already swiped the current user right
      DocumentSnapshot swipedUserSwipe = await FirebaseFirestore.instance
          .collection('locations')
          .doc(locationId)
          .collection('connected_users')
          .doc(swipedUserId)
          .collection('swipes')
          .doc(authController.user.uid)
          .get();

      // Check if both users swiped right (a match occurred)
      if (swipedUserSwipe.exists) {
        Swipe swipedUserSwipeData = Swipe.fromSnapshot(swipedUserSwipe);
        if (swipedUserSwipeData.swipeDirection == SwipeTypeEnum.right) {
          print('USER SWPIED YOU RIGHT MATCHED!!!');
          //setting the current User's Match
          String randomMatchId = RandomIdGenerator.generateUniqueId();
          String currentUsersId = authController.user.uid;
          String matchedUsersId = swipedUserSwipeData.swipedUserId;
          Match currentUserMatch = Match(
              matchId: randomMatchId,
              currentUserId: currentUsersId,
              matchedUserId: matchedUsersId,
              locationId: locationId,
              isShown: true);
          firestore
              .collection('locations')
              .doc('Starbucks')
              .collection('connected_users')
              .doc(authController.user.uid)
              .collection('matches')
              .doc(randomMatchId)
              .set(currentUserMatch.toJson());

          Match swipedUserMatch = Match(
              matchId: randomMatchId,
              matchedUserId: currentUsersId,
              currentUserId: matchedUsersId,
              locationId: locationId);
          //setting the swiped User's Match
          firestore
              .collection('locations')
              .doc('Starbucks')
              .collection('connected_users')
              .doc(swipedUserId)
              .collection('matches')
              .doc(randomMatchId)
              .set(swipedUserMatch.toJson());

          await Get.find<UserController>()
              .setHasNewMatches(hasNewMessages: true, userId: currentUsersId);
          await Get.find<UserController>()
              .setHasNewMatches(hasNewMessages: true, userId: swipedUserId);

          return true;
        } else if (swipedUserSwipeData.swipeDirection == SwipeTypeEnum.left) {
          print('USER SWPIED YOU LEFT REJECTED!');
          return false;
        }
      } else {
        print('USER DID NOT SWIPED YOU YET!');

        return false;
      }
    } catch (e) {
      print('Failed to check for a match: $e');
      return false;
    }
    return false;
  }

  void setIsMatchShown(
      {required bool isMatchShown, required String matchId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('locations')
          .doc('Starbucks')
          .collection('matches')
          .doc(matchId)
          .update({'isShown': isMatchShown})
          .then((value) => print('isShown updated successfully'))
          .catchError((error) => print('Failed to update isShown: $error'));
    } catch (e) {
      print('Failed to update isShown: $e');
    }
  }

  void setIsConnectedToPlatform({required bool isConnected}) async {
    _isConnectedToPlatform.value = isConnected;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authController.user.uid)
          .update({'isConnected': isConnected})
          .then((value) => print('isConnected updated successfully'))
          .catchError((error) => print('Failed to update isConnected: $error'));
    } catch (e) {
      print('Failed to update isConnected: $e');
    }
  }
}
