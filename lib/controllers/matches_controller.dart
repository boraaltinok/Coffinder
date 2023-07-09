import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../Models/match.dart';
import '../Models/user.dart' as userModel;
import '../constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MatchesController extends GetxController {
  final RxList<Match> _matches = <Match>[].obs;
  final RxList<userModel.User> _matchedUsers = <userModel.User>[].obs;

  List<Match> get matches => _matches.value;

  List<userModel.User> get matchedUsers => _matchedUsers.value;

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
        print("binding to new user with id ${user.uid} }");
        _bindMatches(userId: user.uid);
      } else {
        // User is logged out, clear the data
        print("binding currentUser ${user?.uid} ");

        _matches.clear();
      }
    });
  }

  void _bindMatches({required String userId}) async {
    _matches.value = [];
    _matches.bindStream(firestore
        .collection('locations')
        .doc('Starbucks')
        .collection('connected_users')
        .doc(userId)
        .collection('matches')
        .snapshots()
        .asyncMap((QuerySnapshot query) async {
      if (query.docs.isEmpty) {
        // Handle empty snapshot here
        print("CURRENTLY MATCHED USERS ARE EMPTY");
        return [];
      } else {
        List<Match> matches =
            query.docs.map((doc) => Match.fromSnapshot(doc)).toList();
        _matchedUsers.value = [];
        for (Match match in matches) {
          userModel.User? matchedUser =
              await authController.getUser(userId: match.matchedUserId);
          if (matchedUser != null) {
            _matchedUsers.value.add(matchedUser!);
          }
          print("FOUND A MATCH $match");
        }
        return matches;
      }
    }));
  }
}
