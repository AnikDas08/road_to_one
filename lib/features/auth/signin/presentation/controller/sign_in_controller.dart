import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../services/storage/storage_services.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;


  /// email and password Controller here
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'developernaimul00@gmail.com' : '',
  );

  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : "",
  );
  RxBool isRemember=false.obs;

  /// Sign in Api call here


  Future<bool> checkProfile() async {
    try {
      var response = await ApiService.get(
        ApiEndPoint.myProvider,
        header: {"Authorization": "Bearer ${LocalStorage.token}"},
      );

      if (response.statusCode == 200) {
        return response.data['data']['aboutMe'] != null;
      }
      else if (response.statusCode == 401) {
        // Session expired → logout
        //AppAuthStorage().clear(); // if available
        LocalStorage.isLogIn = false;
        LocalStorage.token = "";
        LocalStorage.setBool(LocalStorageKeys.isLogIn, false);
        LocalStorage.setString(LocalStorageKeys.token, "");
        return false;
      }
      else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  void rememberMe(bool value) {
    isRemember.value = value;
    update();
  }

  Future<void> signInUser() async {
    //Get.toNamed(AppRoutes.complete_profile_screen);
    //return;

    isLoading = true;
    update();

    Map<String, String> body = {
      "role":"PROVIDER",
      "email": emailController.text,
      "password": passwordController.text,
    };

    var response = await ApiService.post(
      ApiEndPoint.signIn,
      body: body,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = response.data;

      //AppAuthStorage().setToken(data['data']["accessToken"]);
      //AppAuthStorage().setLogin("djfkldfd");

      LocalStorage.token = data['data']["accessToken"];
      LocalStorage.userId = data['data']["id"];
      LocalStorage.isLogIn = true;

      LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
      LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
      LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
      print("klsdjfdkfj😍😍😍😍 ${LocalStorage.userId}");

      if(await checkProfile()==false){
        //Get.offAllNamed(AppRoutes.complete_profile_screen);
      }
      else{
        //Get.offAllNamed(AppRoutes.homeNav);
      }
      //Get.offAllNamed(AppRoutes.complete_profile_screen);//Get.offAllNamed(AppRoutes.homeNav);


      emailController.clear();
      passwordController.clear();

    }

    else if (response.statusCode == 401) {
      LocalStorage.isLogIn = false;
      LocalStorage.token = "";
      LocalStorage.setBool(LocalStorageKeys.isLogIn, false);
      LocalStorage.setString(LocalStorageKeys.token, "");
      //Get.offAllNamed(AppRoutes.onboarding);
    }
    else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
