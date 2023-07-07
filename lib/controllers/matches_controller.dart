import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../Models/match.dart';
import '../Models/user.dart';
import '../constants/constants.dart';

class MatchesController extends GetxController {
  final RxList<Match> _matches = <Match>[].obs;
  final RxList<User> _matchedUsers = <User>[].obs;

  List<Match> get matches => _matches.value;
  List<User> get matchedUsers => _matchedUsers.value;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _bindMatches();
  }


  void _bindMatches() async {
    _matches.bindStream(firestore
        .collection('locations')
        .doc('Starbucks')
        .collection('connected_users')
        .doc(authController.user.uid)
        .collection('matches')
        .snapshots()
        .asyncMap((QuerySnapshot query) async {
      if (query.docs.isEmpty) {
        // Handle empty snapshot here
        print("CURRENTLY MATCHED USERS ARE EMPTY");
        return [];
      } else {
        List<Match> matches = query.docs.map((doc) => Match.fromSnapshot(doc)).toList();
        _matchedUsers.value = [];
        for (Match match in matches) {
          User? matchedUser = await authController.getUser(userId: match.matchedUserId);
          if(matchedUser != null){
            _matchedUsers.value.add(matchedUser!);
          }
          print("FOUND A MATCH $match");
        }
        return matches;
      }
    }));
  }
}