import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:coffinder/Models/location.dart';

import '../constants/constants.dart';

class LocationController extends GetxController {
  Future<Location?> getLocation({required String locationId}) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('locations').doc(locationId).get();

      Location location = Location.fromSnapshot(doc);

      return location;
    } catch (e) {
      Get.snackbar('Error Retrieving', e.toString());
      return null;
    }
  }
}
