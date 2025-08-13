// specific_parcels_of_shipment_entity.dart
class SpecificParcelsOfShipmentEntity {
  final int shipmentId;
  final int declaredParcelsCount;
  final int createdParcelsCount;
  final List<ParcelEntity> parcels;

  SpecificParcelsOfShipmentEntity({
    required this.shipmentId,
    required this.declaredParcelsCount,
    required this.createdParcelsCount,
    required this.parcels,
  });
}

class ParcelEntity {
  final int id;
  final double actualWeight;
  final String length;
  final String width;
  final String height;
  final String status;
  final int customerId;
  final String firstName;
  final String lastName;
  final int itemsCount;
  final double dimensionalWeight;

  ParcelEntity({
    required this.id,
    required this.actualWeight,
    required this.length,
    required this.width,
    required this.height,
    required this.status,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.itemsCount,
    required this.dimensionalWeight,
  });
}
