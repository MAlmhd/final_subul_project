import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/un_approved_shipment_entity/un_approved_shipments_entity.dart';

class UnapprovedShipmentModel extends UnApprovedShipmentsEntity {
  final int id;
  final String trackingNumber;
  final String type;
  final int customerId;
  final String? customerName;
  final String? status;
  final int declaredParcelsCount;
  final DateTime createdAt;

  // ✅ جديد
  final String? invoiceFile2;

  UnapprovedShipmentModel({
    required this.id,
    required this.trackingNumber,
    required this.type,
    required this.customerId,
    required this.customerName,
    required this.status,
    required this.declaredParcelsCount,
    required this.createdAt,
    this.invoiceFile2,
  }) : super(
          id,
          trackingNumber,
          type,
          customerId,
          customerName ?? "No Name",
          status ?? "",
          declaredParcelsCount,
           invoiceFile2,    // ✅ مرّرها للـ Entity
                 // (اختياري) تمرير التاريخ
        );

  factory UnapprovedShipmentModel.fromJson(Map<String, dynamic> json) {
    return UnapprovedShipmentModel(
      id: json['id'] as int,
      trackingNumber: json['tracking_number'] as String,
      type: json['type'] as String,
      customerId: json['customer_id'] as int,
      customerName: json['customer_name'] as String?,
      status: json['status'] as String?,
      declaredParcelsCount: json['declared_parcels_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      invoiceFile2: json['invoice_file'] as String?, // ✅ قراءة الرابط
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tracking_number': trackingNumber,
      'type': type,
      'customer_id': customerId,
      'customer_name': customerName,
      'status': status,
      'declared_parcels_count': declaredParcelsCount,
      'created_at': createdAt.toIso8601String(),
      'invoice_file': invoiceFile2, // ✅ كتابة الرابط
    };
  }
}
