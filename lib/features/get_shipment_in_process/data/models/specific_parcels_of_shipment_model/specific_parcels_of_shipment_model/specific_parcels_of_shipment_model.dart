// specific_parcels_of_shipment_model.dart
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/specific_parcels_of_shipment_entity/specific_parcels_of_shipment_entity.dart';

class SpecificParcelsOfShipmentModel extends SpecificParcelsOfShipmentEntity {
  SpecificParcelsOfShipmentModel({
    required super.shipmentId,
    required super.declaredParcelsCount,
    required super.createdParcelsCount,
    required List<ParcelModel> super.parcels,
  });

  factory SpecificParcelsOfShipmentModel.fromJson(Map<String, dynamic> json) {
    return SpecificParcelsOfShipmentModel(
      shipmentId: json['shipment_id'] ?? 0,
      declaredParcelsCount: json['declared_parcels_count'] ?? 0,
      createdParcelsCount: json['created_parcels_count'] ?? 0,
      parcels: (json['parcels'] as List<dynamic>?)
              ?.map((e) => ParcelModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <ParcelModel>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipment_id': shipmentId,
      'declared_parcels_count': declaredParcelsCount,
      'created_parcels_count': createdParcelsCount,
      'parcels': parcels.map((e) => (e as ParcelModel).toJson()).toList(),
    };
  }
}

class ParcelModel extends ParcelEntity {
  ParcelModel({
    required super.id,
    required super.actualWeight,
    required super.length,
    required super.width,
    required super.height,
    required super.status,
    required super.customerId,
    required super.firstName,
    required super.lastName,
    required super.itemsCount,
    required super.dimensionalWeight,
  });

  factory ParcelModel.fromJson(Map<String, dynamic> json) {
    return ParcelModel(
      id: json['id'] ?? 0,
      actualWeight: (json['actual_weight'] as num?)?.toDouble() ?? 0.0,
      length: json['length']?.toString() ?? '',
      width: json['width']?.toString() ?? '',
      height: json['height']?.toString() ?? '',
      status: json['status'] ?? '',
      customerId: json['customer_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      itemsCount: json['items_count'] ?? 0,
      dimensionalWeight: (json['dimensional_weight'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'actual_weight': actualWeight,
      'length': length,
      'width': width,
      'height': height,
      'status': status,
      'customer_id': customerId,
      'first_name': firstName,
      'last_name': lastName,
      'items_count': itemsCount,
      'dimensional_weight': dimensionalWeight,
    };
  }
}
