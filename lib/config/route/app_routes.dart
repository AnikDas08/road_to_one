import 'package:get/get.dart';
import 'package:road_project_flutter/features/auth/change_password/presentation/screen/change_password.dart';
import 'package:road_project_flutter/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:road_project_flutter/features/auth/forget_password/presentation/screen/verify_screen.dart';
import 'package:road_project_flutter/features/auth/phone_signup/presentation/screen/phone_signup.dart';
import 'package:road_project_flutter/features/auth/signin/presentation/screen/sign_in_screen.dart';
import 'package:road_project_flutter/features/auth/signup/presentation/screen/signup_screens.dart';
import 'package:road_project_flutter/features/auth/signup/presentation/screen/verify_user_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/calender_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/my_plan_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/myprogress_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/plan_details_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/cart_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/create_post_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/home_nav_screen.dart';
import 'package:road_project_flutter/features/onboarding/presentation/screen/onboarding_first.dart';
import 'package:road_project_flutter/features/onboarding/presentation/screen/onboarding_second.dart';
import 'package:road_project_flutter/features/onboarding/presentation/screen/onboarding_three.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/edit_profile_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/network_screen.dart';
import 'package:road_project_flutter/features/splash/splash_screen.dart';
class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String splash = "/splsah";
  static const String signUp = "/signUp";
  static const String signIn = "/signIn";
  static const String phoneSignupScreen = "/phoneSignupScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String verifyUser="/verifyUser";
  static const String verifyAccount="/verifyAccount";
  static const String changePassword="/changePassword";
  static const String onBoardingFirst="/onBoardingFirst";
  static const String onBoardingSecond="/onBoardingSecond";
  static const String onBoardingThree="/onBoardingThree";
  static const String homeNav="/homeNav";
  static const String createPost="/createPost";
  static const String cartScreen="/cartScreen";
  static const String editProfileScreen="/editProfileScreen";
  static const String networkScreen="/networkScreen";
  static const String myPlanScreen="/myPlanScreen";
  static const String planDetails="/planDetails";
  static const String myProgressScreen="/myProgressScreen";
  static const String calenderScreen="/calenderScreen";


  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: phoneSignupScreen, page: () => const PhoneSignUpScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUserScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUserScreen()),
    GetPage(name: verifyAccount, page: () => const VerifyScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: onBoardingFirst, page: () => OnboardingFirst()),
    GetPage(name: onBoardingSecond, page: () => OnboardingSecondScreen()),
    GetPage(name: onBoardingThree, page: () => OnboardingThreeScreen()),
    GetPage(name: homeNav, page: () => HomeNavScreen()),
    GetPage(name: createPost, page: () => CreatePostScreen()),
    GetPage(name: cartScreen, page: () => CartScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: networkScreen, page: () => NetworkScreen()),
    GetPage(name: myPlanScreen, page: () => MyPlanScreen()),
    GetPage(name: planDetails, page: () => PlanDetailScreen()),
    GetPage(name: myProgressScreen, page: () => MyProgressScreen()),
    GetPage(name: calenderScreen, page: () => CalendarScreen()),
  ];
}
