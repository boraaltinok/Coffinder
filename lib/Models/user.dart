import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Models/user_images.dart';

class User {
  String name;
  String email;
  String uid;
  String gender;
  int age;
  UserImages userImages; // UserImages sub-collection

  User({
    required this.name,
    required this.uid,
    required this.email,
    required this.gender,
    required this.age,
    required this.userImages,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'uid': uid,
    'email': email,
    'gender': gender,
    'age': age,
    'userImages': userImages.toJson(), // Convert UserImages sub-collection to JSON
  };

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var userImagesData = data['userImages'] as Map<String, dynamic>;
    var userImages = UserImages.fromJson(userImagesData);
    return User(
      name: data['name'],
      uid: data['uid'],
      email: data['email'],
      gender: data['gender'],
      age: data['age'],
      userImages: userImages,
    );
  }
}
