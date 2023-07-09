import 'package:coffinder/screens/AuthScreens/SignInScreens/sign_in_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/add_photos_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/age_selection_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/email_verification_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/gender_selection_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/page_view_intro_screen.dart';
import 'package:coffinder/screens/AuthScreens/SignUpScreens/sign_up_screen.dart';
import 'package:coffinder/screens/AuthScreens/select_auth_method_screen.dart';
import 'package:coffinder/screens/HomePageScreens/home_page.dart';
import 'package:get/get.dart';



class AppRoutes {
  static const home = '/';
  static const selectAuthMethod = '/select-auth-method';
  static const signIn= '/signIn';
  static const register= '/register';
  static const intro = '/intro';
  static const ageSelection = '/age-selection';
  static const genderSelection = '/gender-selection';
  static const emailVerification = '/email-verification';
  static const addPhotos = '/add-photos';


  static final routes = [
    GetPage(name: home, page: ()=> const HomePage()),
    GetPage(name: intro, page: ()=> const PageViewIntroScreen(),),
    GetPage(name: selectAuthMethod, page: ()=> const SelectAuthMethodScreen()),
    GetPage(name: signIn, page: ()=>  const SignInScreen(), transition: Transition.leftToRightWithFade, transitionDuration: const Duration(milliseconds: 800)),
    GetPage(name: register, page: ()=> const SignUpScreen(),transition: Transition.leftToRightWithFade, transitionDuration: const Duration(milliseconds: 800)),
    GetPage(name: ageSelection, page: ()=> const AgeSelectionScreen(),transition: Transition.leftToRightWithFade, transitionDuration: const Duration(milliseconds: 800)),
    GetPage(name: genderSelection, page: ()=> const GenderSelectionScreen(),transition: Transition.leftToRightWithFade, transitionDuration: const Duration(milliseconds: 800)),
    GetPage(name: emailVerification, page: ()=> const EmailVerificationScreen(),transition: Transition.leftToRightWithFade, transitionDuration: const Duration(milliseconds: 800)),
    GetPage(name: addPhotos, page: ()=> const AddPhotosScreen(),transition: Transition.leftToRightWithFade, transitionDuration: const Duration(milliseconds: 800)),

  ];
}