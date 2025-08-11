class ShipmentInTheWayEntity {
  final int id;
  final String trackingNumber;
  final String type;
  final String customerName;
  final String status;
  final int actualParcelsCount;
  final String originCountry;
  final String destinationCountry;

  ShipmentInTheWayEntity({required this.id, required this.trackingNumber, required this.type, required this.customerName, required this.status, required this.actualParcelsCount, required this.originCountry, required this.destinationCountry});
}
