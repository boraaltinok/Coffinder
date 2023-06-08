import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  String locationId;
  String name;
  double latitude;
  double longitude;

  Location({
    required this.locationId,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    "locationId": locationId,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
  };

  static Location fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Location(
      locationId: data['locationId'],
      name: data['name'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}