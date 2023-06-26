import 'package:coffinder/Utilities/RandomIdGenerator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Models/user_images.dart';
import '../constants/constants.dart';

class ImagePickerController extends GetxController {
  final RxList<File?> _selectedImages = List<File?>.filled(6, null).obs;

  get selectedImages => _selectedImages.value;

  final RxInt _selectedImageCount = 0.obs;

  int get selectedImageCount => _selectedImageCount.value;




  void pickImageToPosition({required ImageSource source, required int position}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        final imageFile = File(pickedImage.path);
        _selectedImages[position] = imageFile;
        print("after adding the _selectedImages.value = ${_selectedImages.value}");
        print("after adding the _selectedImages.position = ${_selectedImages.value[position]}");
        _selectedImageCount.value++;


      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> uploadSelectedImages() async {

    final userDocRef = firestore.collection('users').doc(authController.user.uid);

    final userSnapshot = await userDocRef.get();

    final userImagesData = userSnapshot.data()?['userImages'] ?? {};
    final userImages = UserImages.fromJson(userImagesData);



    for (var image in selectedImages) {
      if (image != null) {
        print("inside");
        String downloadUrl = await _uploadToStorage(image);
        // Save the download URL to Firestore or perform any necessary actions
        print('Image uploaded to Firebase Storage. Download URL: $downloadUrl');

        final newImage = UserImage(
          imageId: RandomIdGenerator.generateUniqueId(), // Generate a unique ID for the image
          imageUrl: downloadUrl,
          timestamp: DateTime.now(),
        );
        userImages.images.add(newImage);
      }
    }
    // Convert the updated UserImages object to JSON
    final userImagesJson = userImages.toJson();

    // Update the user document with the updated userImages field
    await userDocRef.update({'userImages': userImagesJson});

  }



  //upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = firebaseStorage
        .ref()
        .child('profilePictures')
        .child(firebaseAuth.currentUser!.uid)
        .child(uniqueFileName);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}