import 'dart:convert';

class ProviderModel {
  final String? aboutMe;
  final List<ServiceModel> services; // Multiple services
  final List<String> serviceLanguage;
  final String? primaryLocation;
  final Location location;
  final double serviceDistance;
  final double pricePerHour;
  final List<String> uploadedImages;
  final bool isPrivacyAccepted;

  ProviderModel({
    required this.aboutMe,
    required this.services,
    required this.serviceLanguage,
    required this.primaryLocation,
    required this.location,
    required this.serviceDistance,
    required this.pricePerHour,
    required this.uploadedImages,
    required this.isPrivacyAccepted,
  });

  ProviderModel copyWith({
    String? aboutMe,
    List<ServiceModel>? services,
    List<String>? serviceLanguage,
    String? primaryLocation,
    Location? location,
    double? serviceDistance,
    double? pricePerHour,
    List<String>? uploadedImages,
    bool? isPrivacyAccepted,
  }) {
    return ProviderModel(
      aboutMe: aboutMe ?? this.aboutMe,
      services: services ?? this.services,
      serviceLanguage: serviceLanguage ?? this.serviceLanguage,
      primaryLocation: primaryLocation ?? this.primaryLocation,
      location: location ?? this.location,
      serviceDistance: serviceDistance ?? this.serviceDistance,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      isPrivacyAccepted: isPrivacyAccepted ?? this.isPrivacyAccepted,
    );
  }

  factory ProviderModel.fromJson(Map<dynamic, dynamic> json) {
    return ProviderModel(
      aboutMe: json["aboutMe"] ?? '',
      services: (json["services"] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e))
          .toList() ??
          [],
      serviceLanguage: List<String>.from(json["serviceLanguage"] ?? []),
      primaryLocation: json["primaryLocation"] ?? '',
      location: json["location"] != null
          ? Location.fromJson(json["location"])
          : Location(type: "Point", coordinates: [0.0, 0.0]),
      serviceDistance: (json["serviceDistance"] ?? 0).toDouble(),
      pricePerHour: (json["pricePerHour"] ?? 0).toDouble(),
      uploadedImages: List<String>.from(json["uploadedImages"] ?? []),
      isPrivacyAccepted: json["isPrivacyAccepted"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "aboutMe": aboutMe,
      "services": services.map((e) => e.toJson()).toList(),
      "serviceLanguage": serviceLanguage,
      "primaryLocation": primaryLocation,
      "location": location.toJson(),
      "serviceDistance": serviceDistance,
      "pricePerHour": pricePerHour,
      "uploadedImages": uploadedImages,
      "isPrivacyAccepted": isPrivacyAccepted,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}

class ServiceModel {
  final String serviceName;
  final String serviceType;
  final double price;

  ServiceModel({
    required this.serviceName,
    required this.serviceType,
    required this.price,
  });

  ServiceModel copyWith({
    String? serviceName,
    String? serviceType,
    double? price,
  }) {
    return ServiceModel(
      serviceName: serviceName ?? this.serviceName,
      serviceType: serviceType ?? this.serviceType,
      price: price ?? this.price,
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceName: json["serviceName"] ?? '',
      serviceType: json["serviceType"] ?? '',
      price: (json["price"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceName": serviceName,
      "serviceType": serviceType,
      "price": price,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  Location copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return Location(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"] ?? "Point",
      coordinates: List<double>.from(
        (json["coordinates"] ?? [0.0, 0.0]).map((x) => x.toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}
