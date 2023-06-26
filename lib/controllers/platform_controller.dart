import 'package:coffinder/constants/constants.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/user.dart'; // Import your existing User model

class PlatformController extends GetxController {
  final RxList<User> _connectedUsers = <User>[].obs;
  final Rx<bool> _isConnectedToPlatform = Rx<bool>(false);


  List<User> get connectedUsers => _connectedUsers.value;
  bool get isConnectedToPlatform => _isConnectedToPlatform.value;

  @override
  void onInit() {
    super.onInit();
    _bindConnectedUsers();
  }


  /// Binds the connected users to the platform controller by retrieving their
  /// user documents from the 'connected_users' collection in the specified location.
  /// The retrieved user documents are used to populate the [_connectedUsers] list.
  void _bindConnectedUsers() {
    _connectedUsers.bindStream(firestore
        .collection('locations')
        .doc('1')
        .collection('connected_users')
        .snapshots()
        .asyncMap((QuerySnapshot query) async {
      List<String> connectedUserIds = query.docs.map((doc) => doc.id).toList();
      List<User> connectedUsers = [];

      for (String userId in connectedUserIds) {
        DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          User user = User.fromSnapshot(userDoc);
          connectedUsers.add(user);
        }
      }
      return connectedUsers;
    }));
  }

  void setIsConnectedToPlatform ({required bool isConnected}){
    _isConnectedToPlatform.value = isConnected;
  }



// Other methods and logic for your platform controller
}