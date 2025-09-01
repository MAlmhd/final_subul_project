// ===== Entity =====
class ApprovedShipmentEntity {
  final int idOfShipment;
  final String trackingString;
  final String typeOfShipment;
  final int idOfCustomer;
  final String nameOfCustomer;
  final String? statusOfShipment;
  final int? numberOfShipment;
  final DateTime createdAt;
  final String? invoiceFile; // قد تكون null

  ApprovedShipmentEntity(
    this.idOfShipment,
    this.trackingString,
    this.typeOfShipment,
    this.idOfCustomer,
    this.nameOfCustomer,
    this.statusOfShipment,
    this.numberOfShipment,
    this.createdAt,
    this.invoiceFile,
  );
}
