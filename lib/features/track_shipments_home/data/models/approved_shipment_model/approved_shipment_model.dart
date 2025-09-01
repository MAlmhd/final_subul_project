// ===== Model =====
import 'package:final_subul_project/features/track_shipments_home/domain/entities/approved_shipment_entity/approved_shipment_entity.dart';

class ApprovedShipmentModel extends ApprovedShipmentEntity {
  // نُبقي الحقول هنا (كما في كودك السابق) لضمان التوافق مع أي استعمالات سابقة
  final int id;
  final String trackingNumber;
  final String type;
  final int customerId;
  final String? customerName;
  final String? status;
  final int? declaredParcelsCount;
  final DateTime createdAt;
  final String? invoiceFile; // جديد

  ApprovedShipmentModel({
    required this.id,
    required this.trackingNumber,
    required this.type,
    required this.customerId,
    this.customerName,
    this.status,
     this.declaredParcelsCount,
    required this.createdAt,
    this.invoiceFile,
  }) : super(
          id,
          trackingNumber,
          type,
          customerId,
          customerName ?? " No name",
          status,
          declaredParcelsCount,
          createdAt,
          invoiceFile,
        );

  factory ApprovedShipmentModel.fromJson(Map<String, dynamic> json) {
    return ApprovedShipmentModel(
      id: json['id'] as int,
      trackingNumber: json['tracking_number'] as String,
      type: json['type'] as String,
      customerId: json['customer_id'] as int,
      customerName: json['customer_name'] as String?,
      status: json['status'] as String?,
      declaredParcelsCount: json['declared_parcels_count'] ,
      createdAt: DateTime.parse(json['created_at'] as String),
      invoiceFile: json['invoice_file'] as String?, // قد تكون null
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
      'invoice_file': invoiceFile,
    };
  }
}
