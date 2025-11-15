import 'package:get/get.dart';

enum NetworkStatus {
  followRequest,
  following,
  connected,
}

class NetworkUser {
  final String id;
  final String name;
  final String role;
  final String image;
  final Rx<NetworkStatus> status;

  NetworkUser({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
    required NetworkStatus status,
  }) : status = status.obs;
}