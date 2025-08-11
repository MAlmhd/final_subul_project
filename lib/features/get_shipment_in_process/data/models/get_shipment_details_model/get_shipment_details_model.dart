import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_shipment_details_entity/get_shipment_details_entity.dart';

class GetShipmentDetailsModel extends GetShipmentDetailsEntity {
  String? shipmentDate2;
  String? customerName2;
  String? customerPhone2;
  dynamic receiptNumber2;
  String? shipmentCode2;
  int? parcelsCount2;
  double? totalWeight;
  String? notes2;

  GetShipmentDetailsModel({
    this.shipmentDate2,
    this.customerName2,
    this.customerPhone2,
    this.receiptNumber2,
    this.shipmentCode2,
    this.parcelsCount2,
    this.totalWeight,
    this.notes2,
  }) : super(
         shipmentDate: shipmentDate2 ?? "",
         customerName: customerName2 ?? "",
         customerPhone: customerPhone2 ?? "",
         receiptNumber: receiptNumber2 ?? "",
         shipmentCode: shipmentCode2 ?? "",
         parcelsCount: parcelsCount2 ?? 0,
         weight: totalWeight ?? 0.0,
         notes: notes2 ?? "",
       );
  factory GetShipmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return GetShipmentDetailsModel(
      shipmentDate2: json['shipment_date'] as String?,
      customerName2: json['customer_name'] as String?,
      customerPhone2: json['customer_phone'] as String?,
      receiptNumber2: json['receipt_number']?.toString(), // ✅ هنا التعديل
      shipmentCode2: json['shipment_code'] as String?,
      parcelsCount2: json['parcels_count'] as int?,
      totalWeight:
          (json['total_weight'] as num?)?.toDouble(), // ⛳ جيد لضمان النوع
      notes2: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'shipment_date': shipmentDate,
    'customer_name': customerName,
    'customer_phone': customerPhone,
    'receipt_number': receiptNumber,
    'shipment_code': shipmentCode,
    'parcels_count': parcelsCount,
    'total_weight': totalWeight,
    'notes': notes,
  };
}
