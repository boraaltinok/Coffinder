import 'package:cloud_firestore/cloud_firestore.dart';

class UserImages {
  List<UserImage> images;

  UserImages({
    required this.images,
  });

  Map<String, dynamic> toJson() => {
    'images': images.map((image) => image.toJson()).toList(),
  };

  static UserImages fromJson(Map<String, dynamic> json) {
    var imagesData = json['images'] as List<dynamic>;
    var images = imagesData.map((imageData) => UserImage.fromJson(imageData)).toList();
    return UserImages(
      images: images,
    );
  }
}

class UserImage {
  String imageId;
  String imageUrl;
  DateTime timestamp;

  UserImage({
    required this.imageId,
    required this.imageUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'imageId': imageId,
    'imageUrl': imageUrl,
    'timestamp': Timestamp.fromDate(timestamp),
  };

  static UserImage fromJson(Map<String, dynamic> json) {
    return UserImage(
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}