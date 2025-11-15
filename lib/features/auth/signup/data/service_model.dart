class ServiceItem {
  String? service;
  String? serviceType;

  ServiceItem({required this.service, required this.serviceType});

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'serviceType': serviceType,
    };
  }
}