class ShipmentInProcessEntity {
  final int id;
  final String trackingNumber;
  final String type;
  final String customerName;
  final String status;
  final int declaredParcelsCount;
  final String originCountry;
  final String destinationCountry;
  final String dateOfShipment;

  ShipmentInProcessEntity( {
    required this.id,
    required this.trackingNumber,
    required this.type,
    required this.status,
    required this.declaredParcelsCount,
    required this.originCountry,
    required this.destinationCountry,
    required this.customerName,
    required this.dateOfShipment,
  });
}
