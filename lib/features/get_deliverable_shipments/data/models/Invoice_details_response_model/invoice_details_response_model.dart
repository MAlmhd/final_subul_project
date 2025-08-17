// data/models/invoice_details_models.dart
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_invoice_details_entity/get_invoice_details_entity.dart';

class InvoiceDetailsResponseModel extends InvoiceDetailsResponseEntity {
  const InvoiceDetailsResponseModel({
    required super.success,
    required super.status,
    required super.message,
    required InvoiceDataModel super.data,
  });

  factory InvoiceDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailsResponseModel(
      success: _toBool(json['success']),
      status: _toInt(json['status']),
      message: (json['message'] ?? '').toString(),
      data: InvoiceDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': (data as InvoiceDataModel).toJson(),
      };
}

class InvoiceDataModel extends InvoiceDataEntity {
  const InvoiceDataModel({
    required InvoiceInfoModel super.invoiceDetails,
    required ShipmentDetailsModel super.shipmentDetails,
    required CustomerDetailsModel super.customerDetails,
    required CostsBreakdownModel super.costsBreakdown,
    required super.totalWeight,
    required super.grandTotal,
  });

  factory InvoiceDataModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDataModel(
      invoiceDetails:
          InvoiceInfoModel.fromJson(json['invoice_details'] as Map<String, dynamic>),
      shipmentDetails:
          ShipmentDetailsModel.fromJson(json['shipment_details'] as Map<String, dynamic>),
      customerDetails:
          CustomerDetailsModel.fromJson(json['customer_details'] as Map<String, dynamic>),
      costsBreakdown:
          CostsBreakdownModel.fromJson(json['costs_breakdown'] as Map<String, dynamic>),
      totalWeight: _toNum(json['total_weight']),
      grandTotal: _toNum(json['grand_total']),
    );
  }

  Map<String, dynamic> toJson() => {
        'invoice_details': (invoiceDetails as InvoiceInfoModel).toJson(),
        'shipment_details': (shipmentDetails as ShipmentDetailsModel).toJson(),
        'customer_details': (customerDetails as CustomerDetailsModel).toJson(),
        'costs_breakdown': (costsBreakdown as CostsBreakdownModel).toJson(),
        'total_weight': totalWeight,
        'grand_total': grandTotal,
      };
}

class InvoiceInfoModel extends InvoiceInfoEntity {
  const InvoiceInfoModel({
    required super.id,
    required super.invoiceNumber,
    required super.currency,
    required super.status,
    required super.payableAt,
    required super.paidAt,
    required super.paymentMethod,
    required super.includesTax,
    required super.adjustmentReason,
    required super.adjustedAmount,
  });

  factory InvoiceInfoModel.fromJson(Map<String, dynamic> json) {
    return InvoiceInfoModel(
      id: _toInt(json['id']),
      invoiceNumber: (json['invoice_number'] ?? '').toString(),
      currency: (json['currency'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      payableAt: _toDate(json['payable_at']),
      paidAt: _toDate(json['paid_at']),
      paymentMethod: _toNullableString(json['payment_method']),
      includesTax: _toBool(json['includes_tax']),
      adjustmentReason: _toNullableString(json['adjustment_reason']),
      adjustedAmount: _toNullableNum(json['adjusted_amount']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoice_number': invoiceNumber,
        'currency': currency,
        'status': status,
        'payable_at': _dateOnly(payableAt),
        'paid_at': _dateTimeString(paidAt),
        'payment_method': paymentMethod,
        'includes_tax': includesTax ? 1 : 0,
        'adjustment_reason': adjustmentReason,
        'adjusted_amount': adjustedAmount,
      };
}

class ShipmentDetailsModel extends ShipmentDetailsEntity {
  const ShipmentDetailsModel({
    required super.id,
    required super.trackingNumber,
    required super.type,
    required super.status,
    required super.createdAt,
  });

  factory ShipmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ShipmentDetailsModel(
      id: _toInt(json['id']),
      trackingNumber: (json['tracking_number'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      createdAt: _toDateTime(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tracking_number': trackingNumber,
        'type': type,
        'status': status,
        'created_at': _dateTimeString(createdAt),
      };
}

class CustomerDetailsModel extends CustomerDetailsEntity {
  const CustomerDetailsModel({
    required super.id,
    required super.name,
    required super.customerCode,
    required super.email,
    required super.phone,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: _toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      customerCode: (json['customer_code'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'customer_code': customerCode,
        'email': email,
        'phone': phone,
      };
}

class CostsBreakdownModel extends CostsBreakdownEntity {
  const CostsBreakdownModel({
    required super.amount,
    required super.taxAmount,
    required super.costOfRepacking,
    required super.costOfIsFragile,
    required super.costDeliveryOrigin,
    required super.costExpressOrigin,
    required super.costCustomsOrigin,
    required super.costDeliveryDestination,
    required super.airFreightCost,
  });

  factory CostsBreakdownModel.fromJson(Map<String, dynamic> json) {
    return CostsBreakdownModel(
      amount: _toDouble(json['amount']),
      taxAmount: _toDouble(json['tax_amount']),
      costOfRepacking: _toDouble(json['cost_of_repacking']),
      costOfIsFragile: _toDouble(json['cost_of_is_fragile']),
      costDeliveryOrigin: _toDouble(json['cost_delivery_origin']),
      costExpressOrigin: _toDouble(json['cost_express_origin']),
      costCustomsOrigin: _toDouble(json['cost_customs_origin']),
      costDeliveryDestination: _toDouble(json['cost_delivery_destination']),
      airFreightCost: _toDouble(json['air_freight_cost']),
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'tax_amount': taxAmount,
        'cost_of_repacking': costOfRepacking,
        'cost_of_is_fragile': costOfIsFragile,
        'cost_delivery_origin': costDeliveryOrigin,
        'cost_express_origin': costExpressOrigin,
        'cost_customs_origin': costCustomsOrigin,
        'cost_delivery_destination': costDeliveryDestination,
        'air_freight_cost': airFreightCost,
      };
}

/// ======================
/// Helpers
/// ======================

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}

num _toNum(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v;
  return num.tryParse(v.toString()) ?? 0;
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  final s = v.toString().trim();
  return double.tryParse(s) ?? 0.0;
}

bool _toBool(dynamic v) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  final s = v?.toString().toLowerCase();
  return s == 'true' || s == '1';
}

String? _toNullableString(dynamic v) {
  if (v == null) return null;
  final s = v.toString();
  return s.isEmpty ? null : s;
}

num? _toNullableNum(dynamic v) {
  if (v == null) return null;
  if (v is num) return v;
  return num.tryParse(v.toString());
}

DateTime? _toDate(dynamic v) {
  if (v == null) return null;
  final s = v.toString().trim();
  // "YYYY-MM-DD"
  return DateTime.tryParse(s.replaceFirst(' ', 'T'));
}

DateTime? _toDateTime(dynamic v) {
  if (v == null) return null;
  final s = v.toString().trim();
  // "YYYY-MM-DD HH:MM:SS" -> "YYYY-MM-DDTHH:MM:SS"
  final iso = s.contains(' ') ? s.replaceFirst(' ', 'T') : s;
  return DateTime.tryParse(iso);
}

String? _dateOnly(DateTime? d) => d == null
    ? null
    : '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

String? _dateTimeString(DateTime? d) => d?.toIso8601String();
