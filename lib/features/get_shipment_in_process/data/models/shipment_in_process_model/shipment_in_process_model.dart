import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';

class ShipmentInProcessModel extends ShipmentInProcessEntity {
  final int? id2;
  final String? trackingNumber2;
  final String? type2;
  final String? customerName2;
  final String? status2;
  final int? declaredParcelsCount2;
  final String? originCountry2;
  final String? destinationCountry2;
  final String? createdAt;

  ShipmentInProcessModel({
    this.id2,
    this.trackingNumber2,
    this.type2,
    this.customerName2,
    this.status2,
    this.declaredParcelsCount2,
    this.originCountry2,
    this.destinationCountry2,
    this.createdAt,
  }) : super(
         id: id2 ?? -1,
         trackingNumber: trackingNumber2 ?? '',
         type: type2 ?? '',
         customerName: customerName2 ?? 'No Name',
         status: status2 ?? '',
         declaredParcelsCount: declaredParcelsCount2 ?? 0,
         originCountry: originCountry2 ?? '',
         destinationCountry: destinationCountry2 ?? '',
         dateOfShipment: createdAt ?? '',
       );

  factory ShipmentInProcessModel.fromJson(Map<String, dynamic> json) {
    return ShipmentInProcessModel(
      id2: json['id'] as int?,
      trackingNumber2: json['tracking_number'] as String?,
      type2: json['type'] as String?,
      customerName2: json['customer_name'] as String?,
      status2: json['status'] as String?,
      declaredParcelsCount2: json['declared_parcels_count'] as int?,
      originCountry2: json['origin_country'] as String?,
      destinationCountry2: json['destination_country'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id2,
    'tracking_number': trackingNumber2,
    'type': type2,
    'customer_name': customerName2,
    'status': status2,
    'declared_parcels_count': declaredParcelsCount2,
    'origin_country': originCountry2,
    'destination_country': destinationCountry2,
    'created_at': createdAt,
  };
}
