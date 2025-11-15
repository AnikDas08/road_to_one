import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:road_project_flutter/component/app_storage/storage_key.dart';

Rx<GetStorage> box = GetStorage().obs;
class AppAuthStorage {
  GetStorage box = GetStorage();


  Future<void> setToken(String value) async {
    await box.write(StorageKey.token, value);
  }
  Future<void> setRole(String value) async {
    await box.write(StorageKey.role, value);
  }
  Future<void> setLogin(String value) async {
    await box.write(StorageKey.loginValue, value);
  }

  Future<void> setLanguageValue(String value) async {
    await box.write(StorageKey.language, value);
  }

  bool hasSeenOnboarding() {
    return box.read(StorageKey.onBoarding) ?? false;
  }

  ///////////////// All
  String? getValue(String value) {
    return box.read(value);
  }
  String? getLoginhere(String value) {
    return box.read(value);
  }

  Future<void> removeValue(String value) async {
    await box.remove(value);
  }

  Future<void> setRefreshToken(String value) async {
    await box.write(StorageKey.refreshToken, value);
  }

  String? getRefreshToken() {
    return box.read(StorageKey.refreshToken);
  }
}
