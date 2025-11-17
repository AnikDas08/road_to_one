import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'config/dependency/dependency_injection.dart';
import 'main.dart' as GetStorage;
import 'services/notification/notification_service.dart';
import 'services/socket/socket_service.dart';
import 'services/storage/storage_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  /// 🔹 Make top (status bar) white text globally
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,              // top status bar background
      statusBarIconBrightness: Brightness.dark,  // top icons black
      systemNavigationBarColor: Colors.black,           // 🔥 BOTTOM navbar black
      systemNavigationBarIconBrightness: Brightness.light, // icons white
    ),
  );

  await init();

  runApp(const MyApp());
}

init() async {
  DependencyInjection dI = DependencyInjection();
  dI.dependencies();
  SocketServices.connectToSocket();

  await Future.wait([
    LocalStorage.getAllPrefData(),
    NotificationService.initLocalNotification(),
  ]);
}