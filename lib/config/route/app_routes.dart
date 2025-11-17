import 'package:get/get.dart';
import 'package:road_project_flutter/features/auth/change_password/presentation/screen/change_password.dart';
import 'package:road_project_flutter/features/auth/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:road_project_flutter/features/auth/forget_password/presentation/screen/verify_screen.dart';
import 'package:road_project_flutter/features/auth/phone_signup/presentation/screen/phone_signup.dart';
import 'package:road_project_flutter/features/auth/signin/presentation/screen/sign_in_screen.dart';
import 'package:road_project_flutter/features/auth/signup/presentation/screen/signup_screens.dart';
import 'package:road_project_flutter/features/auth/signup/presentation/screen/verify_user_screen.dart';
import 'package:road_project_flutter/features/business/presentation/screen/personal_detail_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/calender_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/my_plan_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/myprogress_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/plan_details_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/notification_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/about_use_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/change_password_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/delete_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/order_history_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/setting_screen.dart';
import 'package:road_project_flutter/features/messages/presentation/screen/chat_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/shipping_information_update.dart';
import 'package:road_project_flutter/features/store/presentation/screen/cart_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/create_post_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/home_nav_screen.dart';
import 'package:road_project_flutter/features/mealscreen/presentation/screen/details_all_food.dart';
import 'package:road_project_flutter/features/mealscreen/presentation/screen/meal_detail_screen.dart';
import 'package:road_project_flutter/features/onboarding/presentation/screen/onboarding_first.dart';
import 'package:road_project_flutter/features/onboarding/presentation/screen/onboarding_second.dart';
import 'package:road_project_flutter/features/onboarding/presentation/screen/onboarding_three.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/edit_profile_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/network_screen.dart';
import 'package:road_project_flutter/features/splash/splash_screen.dart';
import 'package:road_project_flutter/features/store/presentation/screen/pay_screen.dart';
import 'package:road_project_flutter/features/store/presentation/screen/shipping_information_screen.dart';
import 'package:road_project_flutter/features/store/presentation/screen/store_show.dart';
import 'package:road_project_flutter/features/store/presentation/screen/success_payment_screen.dart';
class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String splash = "/splsah";
  static const String signUp = "/signUp";
  static const String signIn = "/signIn";
  static const String phoneSignupScreen = "/phoneSignupScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String verifyUser="/verifyUser";
  static const String verifyAccount="/verifyAccount";
  static const String setPasswordScreen="/setPasswordScreen";
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
  static const String detailFoodScreen="/detailFoodScreen";
  static const String mealDetailScreen="/mealDetailScreen";
  static const String personalDetailsScreen="/personalDetailsScreen";
  static const String productDetails="/productDetails";
  static const String shippingInformationScreen="/shippingInformationScreen";
  static const String payScreen="/payScreen";
  static const String successImageScreen="/successImageScreen";
  static const String chatScreenImage="/chatScreenImage";
  static const String settingScreen="/settingScreen";
  static const String orderHistoryScreen="/orderHistoryScreen";
  static const String shippingInformationUpdateScreen="/shippingInformationUpdateScreen";
  static const String changePassword="/changePassword";
  static const String aboutUsScreen="/aboutUsScreen";
  static const String deleteScreen="/deleteScreen";
  static const String notificationScreen="/notificationScreen";


  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: phoneSignupScreen, page: () => const PhoneSignUpScreen()),
    GetPage(name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUserScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUserScreen()),
    GetPage(name: verifyAccount, page: () => const VerifyScreen()),
    GetPage(name: setPasswordScreen, page: () => SetPasswordScreen()),
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
    GetPage(name: detailFoodScreen, page: () => BreakfastScreen()),
    GetPage(name: mealDetailScreen, page: () => MealDetailScreen()),
    GetPage(name: personalDetailsScreen, page: () => PersonalDetailScreen()),
    GetPage(name: productDetails, page: () => ProductDetailScreen()),
    GetPage(name: shippingInformationScreen, page: () => ShippingInformationScreen()),
    GetPage(name: payScreen, page: () => PaymentScreen()),
    GetPage(name: successImageScreen, page: () => SuccessPaymentScreen()),
    GetPage(name: chatScreenImage, page: () => ChatScreen()),
    GetPage(name: settingScreen, page: () => SettingsScreen()),
    GetPage(name: orderHistoryScreen, page: () => OrderHistoryScreen()),
    GetPage(name: shippingInformationUpdateScreen, page: () => ShippingInformationUpdateScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: aboutUsScreen, page: () => AboutUsScreen()),
    GetPage(name: deleteScreen, page: () => DeleteScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
  ];
}
