import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';

class ShipmentInTheWayModel extends ShipmentInTheWayEntity {
  int? id2;
  String? trackingNumber2;
  String? type2;
  String? customerName2;
  String? status2;
  int? actualParcelsCount2;
  String? originCountry2;
  String? destinationCountry2;
  DateTime? createdAt;

  ShipmentInTheWayModel({
    this.id2,
    this.trackingNumber2,
    this.type2,
    this.customerName2,
    this.status2,
    this.actualParcelsCount2,
    this.originCountry2,
    this.destinationCountry2,
    this.createdAt,
  }) : super(
         id: id2!,
         trackingNumber: trackingNumber2 ?? "",
         type: type2 ?? "",
         customerName: customerName2 ?? "",
         status: status2 ?? "",
         actualParcelsCount: actualParcelsCount2 ?? 0,
         originCountry: originCountry2 ?? "",
         destinationCountry: destinationCountry2 ?? "",
       );

  factory ShipmentInTheWayModel.fromJson(Map<String, dynamic> json) {
    return ShipmentInTheWayModel(
      id2: json['id'] as int?,
      trackingNumber2: json['tracking_number'] as String?,
      type2: json['type'] as String?,
      customerName2: json['customer_name'] as String?,
      status2: json['status'] as String?,
      actualParcelsCount2: json['actual_parcels_count'] as int?,
      originCountry2: json['origin_country'] as String?,
      destinationCountry2: json['destination_country'] as String?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id2,
    'tracking_number': trackingNumber2,
    'type': type2,
    'customer_name': customerName2,
    'status': status2,
    'actual_parcels_count': actualParcelsCount2,
    'origin_country': originCountry2,
    'destination_country': destinationCountry2,
    'created_at': createdAt?.toIso8601String(),
  };
}
