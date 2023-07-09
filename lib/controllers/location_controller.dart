import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
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
      Get.snackbar('Error Retrievinggg', e.toString());
      return null;
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location services are denied');
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location services are permanently denied, we can not request');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
