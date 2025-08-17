// domain/entities/invoice_details_entities.dart
import 'package:equatable/equatable.dart';

class InvoiceDetailsResponseEntity extends Equatable {
  final bool success;
  final int status;
  final String message;
  final InvoiceDataEntity data;

  const InvoiceDetailsResponseEntity({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [success, status, message, data];
}

class InvoiceDataEntity extends Equatable {
  final InvoiceInfoEntity invoiceDetails;
  final ShipmentDetailsEntity shipmentDetails;
  final CustomerDetailsEntity customerDetails;
  final CostsBreakdownEntity costsBreakdown;
  final num totalWeight;
  final num grandTotal;

  const InvoiceDataEntity({
    required this.invoiceDetails,
    required this.shipmentDetails,
    required this.customerDetails,
    required this.costsBreakdown,
    required this.totalWeight,
    required this.grandTotal,
  });

  @override
  List<Object?> get props => [
        invoiceDetails,
        shipmentDetails,
        customerDetails,
        costsBreakdown,
        totalWeight,
        grandTotal,
      ];
}

class InvoiceInfoEntity extends Equatable {
  final int id;
  final String invoiceNumber;
  final String currency;
  final String status;
  final DateTime? payableAt;
  final DateTime? paidAt;
  final String? paymentMethod;
  final bool includesTax;
  final String? adjustmentReason;
  final num? adjustedAmount;

  const InvoiceInfoEntity({
    required this.id,
    required this.invoiceNumber,
    required this.currency,
    required this.status,
    required this.payableAt,
    required this.paidAt,
    required this.paymentMethod,
    required this.includesTax,
    required this.adjustmentReason,
    required this.adjustedAmount,
  });

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        currency,
        status,
        payableAt,
        paidAt,
        paymentMethod,
        includesTax,
        adjustmentReason,
        adjustedAmount,
      ];
}

class ShipmentDetailsEntity extends Equatable {
  final int id;
  final String trackingNumber;
  final String type;
  final String status;
  final DateTime? createdAt;

  const ShipmentDetailsEntity({
    required this.id,
    required this.trackingNumber,
    required this.type,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, trackingNumber, type, status, createdAt];
}

class CustomerDetailsEntity extends Equatable {
  final int id;
  final String name;
  final String customerCode;
  final String email;
  final String phone;

  const CustomerDetailsEntity({
    required this.id,
    required this.name,
    required this.customerCode,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, customerCode, email, phone];
}

class CostsBreakdownEntity extends Equatable {
  final double amount;
  final double taxAmount;
  final double costOfRepacking;
  final double costOfIsFragile;
  final double costDeliveryOrigin;
  final double costExpressOrigin;
  final double costCustomsOrigin;
  final double costDeliveryDestination;
  final double airFreightCost;

  const CostsBreakdownEntity({
    required this.amount,
    required this.taxAmount,
    required this.costOfRepacking,
    required this.costOfIsFragile,
    required this.costDeliveryOrigin,
    required this.costExpressOrigin,
    required this.costCustomsOrigin,
    required this.costDeliveryDestination,
    required this.airFreightCost,
  });

  @override
  List<Object?> get props => [
        amount,
        taxAmount,
        costOfRepacking,
        costOfIsFragile,
        costDeliveryOrigin,
        costExpressOrigin,
        costCustomsOrigin,
        costDeliveryDestination,
        airFreightCost,
      ];
}
