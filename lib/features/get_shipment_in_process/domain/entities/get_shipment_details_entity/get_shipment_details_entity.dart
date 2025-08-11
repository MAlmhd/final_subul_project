class GetShipmentDetailsEntity {
  final String shipmentDate;
  final String customerName;
  final String customerPhone;
  final String receiptNumber;
  final String shipmentCode;
  final int parcelsCount;
  final double weight;
  final String notes;

  GetShipmentDetailsEntity({required this.shipmentDate, required this.customerName, required this.customerPhone, required this.receiptNumber, required this.shipmentCode, required this.parcelsCount, required this.weight, required this.notes});
}
