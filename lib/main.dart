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
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // icon white
      statusBarBrightness: Brightness.dark,
      // iOS support
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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