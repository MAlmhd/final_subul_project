class GetDeliverableShipmentsEntity {
  final String customerName;
  final String customerCode;
  final String shipmentCreatedAt;
  final int shipmentId;
  final String trackingNumber;

  GetDeliverableShipmentsEntity({required this.customerName, required this.customerCode, required this.shipmentCreatedAt, required this.shipmentId, required this.trackingNumber});
}
