class DeliveryOrderParams {
  final String address;
  final String dateDelivery;
  final String timeDelivery;
  final String orderType;
  final String? lon;
  final String? lat;

  DeliveryOrderParams({
    required this.address,
    required this.dateDelivery,
    required this.timeDelivery,
    required this.orderType,
    this.lon,
    this.lat,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'address': address,
      'date_delivery': dateDelivery,
      'time_delivery': timeDelivery,
      'order_type': orderType,
    };

    if (lat != null) map['LON'] = lat;
    if (lon != null) map['LAT'] = lon;

    return map;
  }
}
