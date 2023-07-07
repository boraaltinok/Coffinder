import 'dart:async';

import 'package:coffinder/Enums/GenderTypeEnum.dart';
import 'package:coffinder/constants/constants.dart';
import 'package:coffinder/routing/app_routes.dart';
import 'package:get/get.dart';

class SignUpProcessController extends GetxController {
  final Rx<GenderEnum?> _gender = Rx<GenderEnum?>(null);
  final Rx<DateTime?> _birthDate = Rx<DateTime>(DateTime(2000, 1, 1));
  late final Rx<String> _email = Rx<String>("");
  late final Rx<String> _username = Rx<String>("");
  late final Rx<String> _password = Rx<String>("");

  late final Rx<bool?> _isEmailVerified =
      Rx<bool?>(firebaseAuth.currentUser?.emailVerified ?? false);
  late final Rx<bool> _readyToSendAgain = Rx<bool>(true);


  Timer? smsVerificationTimer;
  Timer? _readyToSendTimer;
  //late Rx<Timer?> smsVerificationTimer;
  //late Rx<Timer?> _readyToSendTimer;

  bool? get isEmailVerified => _isEmailVerified.value;

  GenderEnum? get gender => _gender.value;

  String get email => _email.value;

  String get username => _username.value;

  String get password => _password.value;

  bool get readyToSendAgain => _readyToSendAgain.value;

  DateTime? get birthDate => _birthDate.value;

  initializeValues() {
    _gender.value = null;
    _birthDate.value = DateTime(2000, 1, 1);
    _email.value = "";
    _username.value = "";
    _password.value = "";
    _isEmailVerified.value = firebaseAuth.currentUser?.emailVerified ?? false;
    _readyToSendAgain.value = true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    initializeValues();
    super.onInit();
  }

  void setSignUpProcessInfo(
      {String? email,
      String? username,
      String? password,
      GenderEnum? genderEnum,
      DateTime? birthDate}) {
    if (email != null) {
      _email.value = email;
    }
    if (username != null) {
      _username.value = username;
    }
    if (password != null) {
      _password.value = password;
    }
    if (genderEnum != null) {
      _gender.value = genderEnum;
    }
    if (birthDate != null) {
      _birthDate.value = birthDate;
    }
  }

  void setEmail({required String email}) {
    _email.value = email;
  }

  void setPassword({required String password}) {
    _password.value = password;
  }

  void setGender({required GenderEnum gender}) {
    _gender.value = gender;
  }

  void setBirthDate({required DateTime date}) {
    _birthDate.value = date;
  }

  void setReadyToSendAgain({required bool isReady}) {
    _readyToSendAgain.value = isReady;
  }

  Future sendSMS() async {
    authController.sendVerificationEmail();
    setReadyToSendAgain(isReady: false);


    stopTimers();  // Cancel existing timers if they are active

    if(!authController.user.emailVerified){
      print("inside not verified");
      smsVerificationTimer = Timer.periodic(const Duration(seconds: 5), (_) {
        checkEmailVerified();
      });
    }
    _readyToSendTimer = Timer(const Duration(seconds: 5), () {
      print("I am also working");
      setReadyToSendAgain(isReady: true);
    });
    /*smsVerificationTimer = Rx<Timer?>(
        Timer.periodic(const Duration(seconds: 5), (_) => checkEmailVerified()));
    _readyToSendTimer = Rx<Timer?>(Timer(Duration(seconds: 5), () {
      print("I am also working");
      setReadyToSendAgain(isReady: true);
    }));*/
  }

  void stopTimers() {
    smsVerificationTimer?.cancel();
    _readyToSendTimer?.cancel();
  }


  Future checkEmailVerified() async {
    print("chcecking $isEmailVerified");
    await firebaseAuth.currentUser!.reload();
    _isEmailVerified.value = firebaseAuth.currentUser!.emailVerified;
    if (_isEmailVerified.value == true) {
      stopTimers();
      Get.toNamed(AppRoutes.addPhotos);
    }
  }
}
